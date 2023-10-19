//
//  WeatherInfoDataLoader.swift
//  WeatherForecast
//
//  Created by 小苹果 on 2023/10/19.
//

import WForecastComponents
import WForecastAPIClient
import ReactiveSwift

public class WeatherInfoDataLoader {
    
    var apiClient: WFAPIClientProtocol {
        return resolveComponent(WFAPIClientProtocol.self)
    }
    
    func start() {
        loadData()
    }
    
    func loadData() {
        apiClient.fetchWeatherInfo(city: 110101) { resultProducer in
            resultProducer.startWithResult { result in
                switch result {
                case .success(let data):
                    print("data: \(data.model.lives?.count ?? 0)")
                case .failure(let error):
                    print("error: \(error.localizedDescription)")
                }
            }
        }
    }
}
