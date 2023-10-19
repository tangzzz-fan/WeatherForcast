//
//  WeatherInfoResultProtocol.swift
//  WForecastModel
//
//  Created by 小苹果 on 2023/10/19.
//

import Foundation

public protocol WeatherInfoResultProtocol {
    var status: String { get }
    var count: String { get }
    var info: String { get }
    var infocode: String { get }
    var lives: [Live]? { get }
    var forecasts: [Forecast]? { get }
    
}

extension WeatherInfoResult: WeatherInfoResultProtocol {}

public struct WeatherInfoResult: Codable {
    enum CodingKeys: String, CodingKey {
        case status
        case count
        case info
        case infocode
        case lives
        case forecasts
    }
    
    public var status: String
    public var count: String
    public var info: String
    public var infocode: String
    public var lives: [Live]?
    public var forecasts: [Forecast]?
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.status = try container.decode(String.self, forKey: .status)
        self.count = try container.decode(String.self, forKey: .count)
        self.info = try container.decode(String.self, forKey: .info)
        self.infocode = try container.decode(String.self, forKey: .infocode)
        self.lives = try container.decodeIfPresent([Live].self, forKey: .lives)
        self.forecasts = try container.decodeIfPresent([Forecast].self, forKey: .forecasts)
    }
}
