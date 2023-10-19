//
//  Forecast.swift
//  WForecastModel
//
//  Created by 小苹果 on 2023/10/19.
//

import Foundation
import WForecastComponents

public protocol ForecastProtocol {
    var city: String { get }
    var adcode: String { get }
    var province: String { get }
    var reporttime: String { get }
    var casts: [Cast] { get }
}

public class Forecast: ForecastProtocol, Codable {
    
    enum CodingKeys: CodingKey {
        case city
        case adcode
        case province
        case reporttime
        case casts
    }
    
    public var city: String
    public var adcode: String
    public var province: String
    public var reporttime: String
    public var casts: [Cast]
   
    public required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.city = try container.decode(String.self, forKey: .city)
        self.adcode = try container.decode(String.self, forKey: .adcode)
        self.province = try container.decode(String.self, forKey: .province)
        self.reporttime = try container.decode(String.self, forKey: .reporttime)
        self.casts = try container.decode([Cast].self, forKey: .casts)
    }
   
}
