//
//  WFAPIClient.swift
//  WForecastAPIClient
//
//  Created by 小苹果 on 2023/10/19.
//

import Moya
import ReactiveMoya
import ReactiveSwift
import WForecastComponents
import WForecastModel

public typealias WFAPIClientProducer<T> = SignalProducer<(model: T, raw: Data), Error>
public typealias WFAPIClientResultBlock<T> = (SignalProducer<(model: T, raw: Data), Error>) -> Void
public typealias WFAPIClientResponseBlock<T> = (SignalProducer<T, Error>) -> Void

let WFAPIClientBundle = Bundle(for: WFAPIClient.self)

public protocol APIStubProvider {
    func stubDataFor(target: DataService) -> Data?
}

public class WFAPIClient: WFAPIClientProtocol {
    
    let dataProvider: MoyaProvider<DataService>
    let dispatchQueue = DispatchQueue.global(qos: .userInitiated)
    let environmentConfiguration: EnvironmentConfigurationProtocol
    
    public enum APIStubStrategy {
        case defaultImmediateStubs
        case stubClosureForAllRequests(Endpoint.SampleResponseClosure)
        case stubFromProvider(APIStubProvider)
        case delayedStubs(seconds: TimeInterval)
        case none
    }
    
    // swiftlint:disable force_try
    public init(environmentConfiguration: EnvironmentConfigurationProtocol,
                stubStrategy: APIStubStrategy = .none) {
        self.environmentConfiguration = environmentConfiguration
        
        let config = NetworkLoggerPlugin.Configuration(logOptions: .verbose)
        let moyaPlugins = [NetworkLoggerPlugin(configuration: config)]
        
        let stubClosure: (DataService) -> StubBehavior
        switch stubStrategy {
        case .defaultImmediateStubs, .stubClosureForAllRequests, .stubFromProvider:
            stubClosure = MoyaProvider<DataService>.immediatelyStub
        case .delayedStubs(let seconds):
            stubClosure = MoyaProvider<DataService>.delayedStub(seconds)
        case .none:
            stubClosure = MoyaProvider<DataService>.neverStub
        }
        
        let customEndpointClosure: MoyaProvider<DataService>.EndpointClosure
        switch stubStrategy {
        case .stubClosureForAllRequests(let responseClosure):
            customEndpointClosure = { (target: DataService) -> Endpoint in
                return Endpoint(url: try! URL(wfTarget: target).absoluteString,
                                sampleResponseClosure: responseClosure,
                                method: target.method,
                                task: target.task,
                                httpHeaderFields: target.headers)
            }
        case .none, .defaultImmediateStubs, .delayedStubs:
            customEndpointClosure = { (target: DataService) -> Endpoint in
                return Endpoint(
                    url: try! URL(wfTarget: target).absoluteString,
                    sampleResponseClosure: { .networkResponse(200, target.sampleData) },
                    method: target.method,
                    task: target.task,
                    httpHeaderFields: target.headers
                )
            }
        case .stubFromProvider(let provider):
            customEndpointClosure = { (target: DataService) -> Endpoint in
                let stubData = provider.stubDataFor(target: target) ?? target.sampleData
                return Endpoint(
                    url: try! URL(wfTarget: target).absoluteString,
                    sampleResponseClosure: { .networkResponse(200, stubData) },
                    method: target.method,
                    task: target.task,
                    httpHeaderFields: target.headers
                )
            }
        }
        
        dataProvider = MoyaProvider<DataService>(endpointClosure: customEndpointClosure,
                                                 stubClosure: stubClosure,
                                                 plugins: moyaPlugins)
    }
    
    func fetchData<ParsedDataProtocol, ParsedData: Codable>
    (parsedType: ParsedData.Type,
     endpointBlock: @escaping () -> DataService,
     resultBlock: @escaping WFAPIClientResultBlock<ParsedDataProtocol>) {
        let endpoint = endpointBlock()
        let dataSignalProducer = self.dataProvider.reactive.request(endpoint, 
                                                                    callbackQueue: self.dispatchQueue)
            // networking request
            .mapError({ [weak self] (moyaError) -> Error in
                let error = moyaError as Error
                // deliver network error to view
                return self?.handleError(error) ?? error
            })
            .attemptMap({ [weak self] (response) -> (model: ParsedDataProtocol, raw: Data) in
                if let model: ParsedDataProtocol = self?.handleSuccess(response: response,
                                                                       parsedType: parsedType) {
                    return (model: model, raw: response.data)
                } else if let apiError = try? response.map(APIErrorResponse.self) {
                    throw self?.handleError(apiError) ?? apiError
                } else {
                    throw self?.handleError(MoyaError.statusCode(response)) ??
                    ParsingError.castingModelToProtocolType
                }
            })
        resultBlock(dataSignalProducer) // send SignalProducer to the result block
    }
    
    private func handleSuccess<ParsedDataProtocol,
                               ParsedData: Codable>(
        response: Response,
        parsedType: ParsedData.Type) -> ParsedDataProtocol? {
            guard let response = try? response.filterSuccessfulStatusCodes() else {
                return nil
            }
            
            guard let model = try? response.map(parsedType),
                  let anyModel = model as? ParsedDataProtocol else {
                return nil
            }
            
            return anyModel
        }
    
    private func handleError(_ error: Error) -> Error {
        var statusCode: Int = 0
        
        let moyaResponse = (error as? MoyaError)?.response
        
        if let code = (error as? APIErrorResponse)?.statusCode {
            statusCode = code
        } else if let code = moyaResponse?.statusCode {
            statusCode = code
        }
        
        switch statusCode {
        case APIErrorCodes.forbidden.rawValue:
            return PermissionError()
        case APIErrorCodes.notFound.rawValue:
            return NotFoundError()
        case APIErrorCodes.internalServerError.rawValue:
            return NetworkError()
        default: break
        }
        
        return error
    }
    
}

public struct PermissionError: Error {}

public struct NotFoundError: Error {}

public struct NetworkError: Error {}

enum ParsingError: Error {
    case castingModelToProtocolType
}
