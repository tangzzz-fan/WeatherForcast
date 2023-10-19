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
        let viewModel = ContainerViewModel()
        let viewController = ContainerViewController(viewModel: viewModel)
        navigationController.pushViewController(viewController, animated: false)
    }
}

