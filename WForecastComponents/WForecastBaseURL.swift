//
//  WForecastBaseURL.swift
//  WForecastComponents
//
//  Created by 小苹果 on 2023/10/19.
//
// swiftlint:disable nesting

import Foundation

public struct WForecastBaseURL {
    public let scheme: String
    public let domain: String
    public let environment: String
    public let version: String
    
    public var urlString: String {
        return scheme + "://" + environment + "." + domain + "/" + version
    }
    
    private struct Secrets {
        static var scheme = "https"

        struct ApiEnvironment {
            static let PROD = "restapi"
            static let DEV = "restapi"
        }
        
        struct ApiVersion {
            static var DEV = "v3"
            static var PROD = "v3"
        }
        
        struct DomainURL {
            static var PROD = "amap.com"
            static var DEV = "amap.com"
        }

    }
    
    init(environment: Environment) {
        self.scheme = Secrets.scheme
        self.domain = WForecastBaseURL.getDomain(forEnvironment: environment)
        self.version = WForecastBaseURL.getApiVersion(forEnvironment: environment)
        self.environment = WForecastBaseURL.getApiEnvironment(forEnvironment: environment)
    }
    
    private static func getApiEnvironment(forEnvironment env: Environment) -> String {
        switch env {
        case .PROD:
            return Secrets.ApiEnvironment.PROD
        case .DEV:
            return Secrets.ApiEnvironment.DEV
        }
    }
    
    private static func getApiVersion(forEnvironment env: Environment) -> String {
        switch env {
        case .DEV:
            return Secrets.ApiVersion.DEV
        case .PROD:
            return Secrets.ApiVersion.PROD
        }
    }
    
    private static func getDomain(forEnvironment env: Environment) -> String {
        switch env {
        case .DEV:
            return Secrets.DomainURL.DEV
        case .PROD:
            return Secrets.DomainURL.PROD
        }
    }

}
