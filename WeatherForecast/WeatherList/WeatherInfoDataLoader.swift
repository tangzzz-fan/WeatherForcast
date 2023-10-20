//
//  WeatherInfoDataLoader.swift
//  WeatherForecast
//
//  Created by 小苹果 on 2023/10/19.
//

import WForecastComponents
import WForecastAPIClient
import ReactiveSwift
import WForecastModel

public class WeatherInfoDataLoader {
    
    var apiClient: WFAPIClientProtocol {
        return resolveComponent(WFAPIClientProtocol.self)
    }
    
    private let cityIndexs: [Int]
    private let maxConcurrentRequests = 10
    
    var dataSource: Signal<[Int: WeatherInfoResultProtocol], Never> { dataSourcePipe.output }
    private var dataSourcePipe = Signal<[Int: WeatherInfoResultProtocol], Never>.pipe()
    
    var loadingError: Signal<Error, Never> { loadingErrorPipe.output }
    private var loadingErrorPipe = Signal<Error, Never>.pipe()
    
    init(cityIndexs: [Int]) {
        self.cityIndexs = cityIndexs
    }
    
    func start() {
        let group = DispatchGroup()
        let semaphore = DispatchSemaphore(value: maxConcurrentRequests)
        var results: [Int: WeatherInfoResultProtocol] = [:]
        
        for cityIndex in cityIndexs {
            semaphore.wait()
            group.enter()
            
            apiClient.fetchWeatherInfo(city: cityIndex) { resultProducer in
                resultProducer.startWithResult {[weak self] result in
                    defer {
                        semaphore.signal()
                        group.leave()
                    }
                    
                    switch result {
                    case .success(let data):
                        results[cityIndex] = data.model
                    case .failure(let error):
                        print("error: \(error.localizedDescription)")
                        self?.loadingErrorPipe.input.send(value: error)
                    }
                }
            }
        }
        
        group.notify(queue: .main) {[weak self] in
            print("All requests are finished. Results: \(results)")
            self?.dataSourcePipe.input.send(value: results)
        }
    }
    
    deinit {
        debugPrint("\(type(of: self)) deinit")
    }
}
