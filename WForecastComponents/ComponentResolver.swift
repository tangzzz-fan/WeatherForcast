//
//  ComponentResolver.swift
//  WForecastComponents
//
//  Created by 小苹果 on 2023/10/19.
//

import Swinject

private let defaultContainer = Container()
private let defaultAssembler = Assembler(container: defaultContainer)
private let threadSafeContainer: Resolver = defaultContainer.synchronize()

public func applyAssembly(_ assembly: Assembly) {
    defaultAssembler.apply(assembly: assembly)
}

public func registerComponent<T>(_ serviceType: T.Type,
                                 scope: ObjectScope = .container,
                                 factory: @escaping (Resolver) -> T) {
    defaultContainer.register(serviceType, factory: factory).inObjectScope(scope)
}

public func resolveComponent<T>(_ serviceType: T.Type) -> T {
    guard let resolved = threadSafeContainer.resolve(serviceType) else {
        fatalError("Missing dependency")
    }
    return resolved
}

public func resolveComponentIfPresent<T>(_ serviceType: T.Type) -> T? {
    return threadSafeContainer.resolve(serviceType)
}

public func resetContainer() {
    defaultContainer.removeAll()
}
