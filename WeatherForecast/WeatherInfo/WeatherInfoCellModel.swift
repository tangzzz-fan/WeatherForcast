//
//  WeatherInfoCellViewModel.swift
//  WeatherForecast
//
//  Created by 小苹果 on 2023/10/20.
//

import Foundation
import WForecastModel
import WForecastComponents

struct WeatherInfoCellViewModel {
    
    var live: Live?
    var baseInfo: Forecast?
    var todayCast: Cast?
    var tomorrowCast: Cast?
    
    var reportTimeStr: String {
        let reportDate = Date(serverDateString: baseInfo?.reporttime ?? "")
        return reportDate.minuteString
    }
    
    init(_ weatherInfo: WeatherInfoResultProtocol) {
        self.live = weatherInfo.lives?.first
        self.baseInfo = weatherInfo.forecasts?.first
        self.todayCast = weatherInfo.forecasts?.first?.casts[0]
        self.tomorrowCast = weatherInfo.forecasts?.first?.casts[1]
    }
}
