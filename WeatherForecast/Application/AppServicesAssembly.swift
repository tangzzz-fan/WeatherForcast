//
//  AppServicesAssembly.swift
//  WeatherForecast
//
//  Created by 小苹果 on 2023/10/19.
//

import Foundation
import Swinject
import UIKit
import WForecastComponents
import WForecastAPIClient
import WForecastModel
import WForecastUI

final class AppServicesAssembly: Assembly {
    
    var launchOptions: [UIApplication.LaunchOptionsKey: Any]?
    
    init(_ launchOptions: [UIApplication.LaunchOptionsKey: Any]? = nil) {
        self.launchOptions = launchOptions
    }
    
    func assemble(container: Container) {
        container
            .registerComponent(EnvironmentConfigurationProtocol.self) { _ in
                guard let envConfig = try?
                        WForecastEnvironment(environment: .DEV) else {
                    fatalError("Missing environment")
                }
                return envConfig
            }
            .registerComponent(WFAPIClientProtocol.self) { resolver in
                let envConfig = resolver.tryResolve(EnvironmentConfigurationProtocol.self)
                return WFAPIClient(environmentConfiguration: envConfig)
            }
    }
}

private extension Container {
    @discardableResult
    func registerComponent<T>(_ serviceType: T.Type,
                              scope: ObjectScope = .container,
                              factory: @escaping (Resolver) -> T) -> Container {
        register(serviceType, factory: factory).inObjectScope(scope)
        
        return self
    }
}

private extension Resolver {
    func tryResolve<Service>(_ serviceType: Service.Type) -> Service {
        guard let service = resolve(serviceType) else {
            preconditionFailure("Cannot find dependency for type \(String(describing: serviceType))")
        }
        
        return service
    }
}
