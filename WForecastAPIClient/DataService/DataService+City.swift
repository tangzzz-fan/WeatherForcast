//
//  DataService+City.swift
//  WForecastAPIClient
//
//  Created by 小苹果 on 2023/10/19.
//

import WForecastComponents
import Moya

public extension DataService {
    enum City {
        case fetchCityWeatherInfo(
            _ environmentConfiguration: EnvironmentConfigurationProtocol,
            cityCode: Int,
            apiKey: String
        )
    }
}

extension DataService.City {
    var environment: EnvironmentConfigurationProtocol {
        switch self {
        case .fetchCityWeatherInfo(let envConfig, _, _):
            return envConfig
        }
    }
    
    var serviceName: String {
        "weather"
    }
    
    var apiVersion: String {
        "v3"
    }
    
    var parameters: [String: Any] {
        switch self {
        case .fetchCityWeatherInfo(_, let cityCode, let apiKey):
            return ["city": cityCode, "key": apiKey, "extensions": "all"]
        }
    }
}

extension DataService.City {
    var path: String {
        switch self {
        case .fetchCityWeatherInfo:
            return "weatherInfo"
        }
    }
    
    var method: Moya.Method {
        .get
    }
    
    var sampleFileName: String {
        ""
    }
    
    var task: Task {
        return .requestParameters(parameters: parameters, encoding: URLEncoding.default)
    }
}
