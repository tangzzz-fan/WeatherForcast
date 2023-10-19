//
//  EnvironmentConfigurationProtocol.swift
//  WForecastComponents
//
//  Created by 小苹果 on 2023/10/19.
//

import Foundation

public enum Environment: String {
    case DEV
    case PROD
}

public protocol EnvironmentConfigurationProtocol {
    var environment: Environment { get }
    var baseURLString: String { get }
}
