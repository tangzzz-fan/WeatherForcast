//
//  AppFlowCoordinator.swift
//  WeatherForecast
//
//  Created by 小苹果 on 2023/10/19.
//

import UIKit

final class AppFlowCoordinator {

    var navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

    func start() {
        let viewController = ContainerViewController()
        navigationController.pushViewController(viewController, animated: false)
    }
}

