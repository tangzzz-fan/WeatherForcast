//
//  WFAPIClientProtocol.swift
//  WForecastAPIClient
//
//  Created by 小苹果 on 2023/10/19.
//

import WForecastModel

public protocol WFAPIClientProtocol: AnyObject {
    func fetchWeatherInfo(city: Int,
                          resultBlock: @escaping WFAPIClientResultBlock<WeatherInfoResultProtocol>)
}
