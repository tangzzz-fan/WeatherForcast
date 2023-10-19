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
    var dayweather: String { get }
    var nightweather: String { get }
    var daytemp: String { get }
    var nighttemp: String { get }
    var daywind: String { get }
    var nightwind: String { get }
    var daypower: String { get }
    var nightpower: String { get }
    var daytempfloat: String { get }
    var nighttempfloat: String { get }
}

public class Cast: CastProtocol, Codable {
    
    enum CodingKeys: String, CodingKey {
        case date
        case week
        case dayweather
        case nightweather
        case daytemp
        case nighttemp
        case daywind
        case nightwind
        case daypower
        case nightpower
        case daytempfloat = "daytemp_float"
        case nighttempfloat = "nighttemp_float"
    }
    
    public var date: String
    public var week: String
    public var dayweather: String
    public var nightweather: String
    public var daytemp: String
    public var nighttemp: String
    public var daywind: String
    public var nightwind: String
    public var daypower: String
    public var nightpower: String
    public var daytempfloat: String
    public var nighttempfloat: String
    
    public required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.date = try container.decode(String.self, forKey: .date)
        self.week = try container.decode(String.self, forKey: .week)
        self.dayweather = try container.decode(String.self, forKey: .dayweather)
        self.nightweather = try container.decode(String.self, forKey: .nightweather)
        self.daytemp = try container.decode(String.self, forKey: .daytemp)
        self.nighttemp = try container.decode(String.self, forKey: .nighttemp)
        self.daywind = try container.decode(String.self, forKey: .daywind)
        self.nightwind = try container.decode(String.self, forKey: .nightwind)
        self.daypower = try container.decode(String.self, forKey: .daypower)
        self.nightpower = try container.decode(String.self, forKey: .nightpower)
        self.daytempfloat = try container.decode(String.self, forKey: .daytempfloat)
        self.nighttempfloat = try container.decode(String.self, forKey: .nighttempfloat)
    }
    
}

