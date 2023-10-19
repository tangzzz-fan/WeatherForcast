//
//  Live.swift
//  WForecastModel
//
//  Created by 小苹果 on 2023/10/19.
//

import Foundation
import WForecastComponents

public protocol LiveProtocol {
    var province: String { get }
    var city: String { get }
    var adcode: String { get }
    var weather: String { get }
    var temperature: String { get }
    var winddirection: String { get }
    var windpower: String { get }
    var humidity: String { get }
    var reporttime: String { get }
    
}

public class Live: LiveProtocol, Codable {
    
    enum CodingKeys: CodingKey {
        case province
        case city
        case adcode
        case weather
        case temperature
        case winddirection
        case windpower
        case humidity
        case reporttime
    }
    
    public var province: String
    public var city: String
    public var adcode: String
    public var weather: String
    public var temperature: String
    public var winddirection: String
    public var windpower: String
    public var humidity: String
    public var reporttime: String
    
    public required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.province = try container.decode(String.self, forKey: .province)
        self.city = try container.decode(String.self, forKey: .city)
        self.adcode = try container.decode(String.self, forKey: .adcode)
        self.weather = try container.decode(String.self, forKey: .weather)
        self.temperature = try container.decode(String.self, forKey: .temperature)
        self.winddirection = try container.decode(String.self, forKey: .winddirection)
        self.windpower = try container.decode(String.self, forKey: .windpower)
        self.humidity = try container.decode(String.self, forKey: .humidity)
        self.reporttime = try container.decode(String.self, forKey: .reporttime)
    }
}

