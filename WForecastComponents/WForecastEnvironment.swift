//
//  WForecastEnvironment.swift
//  WForecastComponents
//
//  Created by 小苹果 on 2023/10/19.
//

import Foundation

/// Secret
public struct WForecastEnvironment: EnvironmentConfigurationProtocol {
    public let environment: Environment
    
    public var baseURLString: String {
        return baseURL.urlString
    }
    
    private let baseURL: WForecastBaseURL
    
    public init(environment: Environment) throws {
        self.environment = environment
        self.baseURL = WForecastBaseURL(environment: environment)
    }
    
}
