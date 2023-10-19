//
//  EmptyResponse.swift
//  WForecastModel
//
//  Created by 小苹果 on 2023/10/19.
//

import Foundation
import WForecastComponents

public struct APIResponse<T: Codable>: Codable {

    private enum CodingKeys: String, CodingKey {
        case result
        case status
        case count
        case info
        case infocode
    }
    
    public let result: T
    public var status: String
    public var count: String
    public var info: String
    public var infocode: String

    public init(result: T,
                status: String = "",
                count: String = "", 
                info: String = "",
                infocode: String = "") {
        self.result = result
        self.status = status
        self.count = count
        self.info = info
        self.infocode = infocode
    }

    // MARK: - Codable
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.result = try container.decode(T.self, forKey: .result)
        self.status = try container.decode(String.self, forKey: .status)
        self.count = try container.decode(String.self, forKey: .count)
        self.info = try container.decode(String.self, forKey: .info)
        self.infocode = try container.decode(String.self, forKey: .infocode)
    }
    
    public func encode(to encoder: Encoder) throws { }

}

