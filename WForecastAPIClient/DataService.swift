//
//  DataService.swift
//  WForecastAPIClient
//
//  Created by 小苹果 on 2023/10/19.
//

import WForecastComponents
import Moya

public enum DataService {
    case city(City)
}

extension DataService {
    private var environment: EnvironmentConfigurationProtocol {
        switch self {
        case .city(let subtype): return subtype.environment
        }
    }
    
    private var serviceName: String {
        switch self {
        case .city(let subType): return subType.serviceName
        }
    }
    
    private var apiVersion: String {
        switch self {
        case .city(let subtype): return subtype.apiVersion
        }
    }
    
    private var parameters: [String: Any] {
        switch self {
        case .city(let subtype): return subtype.parameters
        }
    }
}

extension DataService: TargetType {
    // swiftlint:disable force_unwrapping
    public var baseURL: URL {
        let urlString = "\(environment.baseURLString)/\(serviceName)"
        return URL(string: urlString)!
    }
    
    public var path: String {
        switch self {
        case .city(let subtype): return subtype.path
        }
    }
    
    public var method: Moya.Method {
        switch self {
        case .city(let subtype): return subtype.method
        }
    }
    
    public var sampleData: Data {
        // Return JSON with error data to simulate different errors
        if sampleError != .noError {
            return readJSONData(sampleError.fileName)
        }
        let fileName: String
        switch self {
        case .city(let subtype): fileName = subtype.sampleFileName
        }
        return readJSONData(fileName)
    }
    
    public var task: Task {
        switch self {
        case .city(let subtype): return subtype.task
        }
    }
    
    public var headers: [String: String]? {
        let headers = [String: String]()
        return headers
    }
}

extension DataService {
    private enum APIErrorType: Int {
        case noError = 0
        case error403 = 403
        case error404 = 404
        
        var fileName: String {
            return "APIError\(rawValue)"
        }
    }
    
    /// Add cases for those response you want to stub with error data form JSON
    private var sampleError: APIErrorType {
        switch self {
        default: return .noError
        }
    }
}

extension DataService {
    
    private func readJSONData(_ fileName: String) -> Data {
        guard
            let URL = WFAPIClientBundle.url(forResource: fileName, withExtension: "json"),
            let data = try? Data(contentsOf: URL) else {
                fatalError("Can't find JSON with name \(fileName) in bundle")
        }
        return data
    }
    
}
