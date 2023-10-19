//
//  Cast.swift
//  WForecastModel
//
//  Created by 小苹果 on 2023/10/19.
//

import Foundation
import WForecastComponents

public protocol CastProtocol {
    var date: String { get }
    var week: String { get }
    var dayWeather: String { get }
    var nightweather: String { get }
    var daytemp: String { get }
    var nighttemp: String { get }
    var daywind: String { get }
    var nightwind: String { get }
    var daypower: String { get }
    var nightpower: String { get }
}

public class Cast: CastProtocol, Codable {
    
    enum CodingKeys: CodingKey {
        case date
        case week
        case dayWeather
        case nightweather
        case daytemp
        case nighttemp
        case daywind
        case nightwind
        case daypower
        case nightpower
    }
    
    public var date: String
    public var week: String
    public var dayWeather: String
    public var nightweather: String
    public var daytemp: String
    public var nighttemp: String
    public var daywind: String
    public var nightwind: String
    public var daypower: String
    public var nightpower: String
    
    public required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.date = try container.decode(String.self, forKey: .date)
        self.week = try container.decode(String.self, forKey: .week)
        self.dayWeather = try container.decode(String.self, forKey: .dayWeather)
        self.nightweather = try container.decode(String.self, forKey: .nightweather)
        self.daytemp = try container.decode(String.self, forKey: .daytemp)
        self.nighttemp = try container.decode(String.self, forKey: .nighttemp)
        self.daywind = try container.decode(String.self, forKey: .daywind)
        self.nightwind = try container.decode(String.self, forKey: .nightwind)
        self.daypower = try container.decode(String.self, forKey: .daypower)
        self.nightpower = try container.decode(String.self, forKey: .nightpower)
    }
    
}

