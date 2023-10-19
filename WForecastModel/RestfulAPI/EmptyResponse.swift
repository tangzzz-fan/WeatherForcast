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
        case infoCode
    }
    
    public let result: T
    public var status: String
    public var count: String
    public var info: String
    public var infoCode: String

    public init(result: T,
                status: String = "",
                count: String = "", 
                info: String = "",
                infoCode: String = "") {
        self.result = result
        self.status = status
        self.count = count
        self.info = info
        self.infoCode = infoCode
    }

    // MARK: - Codable
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: APIResponse<T>.CodingKeys.self)
        self.result = try container.decode(T.self, forKey: APIResponse<T>.CodingKeys.result)
        self.status = try container.decode(String.self, forKey: APIResponse<T>.CodingKeys.status)
        self.count = try container.decode(String.self, forKey: APIResponse<T>.CodingKeys.count)
        self.info = try container.decode(String.self, forKey: APIResponse<T>.CodingKeys.info)
        self.infoCode = try container.decode(String.self, forKey: APIResponse<T>.CodingKeys.infoCode)
    }
    
    public func encode(to encoder: Encoder) throws { }

}

