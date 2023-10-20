//
//  Coordinator.swift
//  WeatherForecast
//
//  Created by 小苹果 on 2023/10/20.
//

import UIKit

protocol Coordinator: AnyObject {
    func start()
    func coordinate(to coordinator: Coordinator)
    func finish(_ completion: (() -> Void)?)
}

extension Coordinator {
    func finish(_ completion: (() -> Void)?) { }
}

extension Coordinator {
    func coordinate(to coordinator: Coordinator) {
        coordinator.start()
    }
}

extension Coordinator where Self: HasRootViewController {
    func finish(_ completion: (() -> Void)?) {
        rootViewController.dismiss(animated: true, completion: completion)
    }
}

protocol HasRootViewController {
    var rootViewController: UIViewController { get }
}
