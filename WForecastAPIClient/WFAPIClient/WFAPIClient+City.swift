//
//  WFAPIClient+City.swift
//  WForecastAPIClient
//
//  Created by 小苹果 on 2023/10/19.
//

import WForecastComponents
import WForecastModel

extension WFAPIClient {
    public func fetchWeatherInfo(city: Int, 
                                 resultBlock: @escaping WFAPIClientResultBlock<WeatherInfoResultProtocol>) {
        let env = self.environmentConfiguration
        fetchData(parsedType: WeatherInfoResult.self, endpointBlock: {
            return DataService.city(.fetchCityWeatherInfo(env, cityCode: city,
                                                          apiKey: "25e2447718b2830737441d6e00776e42"))
        }, resultBlock: resultBlock)

    }
}
