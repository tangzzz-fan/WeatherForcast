//
//  WeatherInfoResultProtocol.swift
//  WForecastModel
//
//  Created by 小苹果 on 2023/10/19.
//

import Foundation

public protocol WeatherInfoResultProtocol {
    var lives: [Live] { get }
    var forecast: Forecast? { get }
}

public typealias WeatherInfoResultData = APIResponse<WeatherInfoResult>
extension WeatherInfoResult: WeatherInfoResultProtocol {}

public struct WeatherInfoResult: Codable {
    enum CodingKeys: String, CodingKey {
        case lives
        case forecast
    }
    
    public var lives: [Live]
    public var forecast: Forecast?
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.lives = try container.decode([Live].self, forKey: .lives)
        self.forecast = try container.decodeIfPresent(Forecast.self, forKey: .forecast)
    }
}
