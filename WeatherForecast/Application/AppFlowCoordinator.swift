//
//  AppFlowCoordinator.swift
//  WeatherForecast
//
//  Created by 小苹果 on 2023/10/19.
//

import UIKit
import WForecastComponents
import ReactiveSwift

final class AppFlowCoordinator: ParentCoordinator {
    var childCoordinator: (Coordinator & HasRootViewController)?
    var childCoordinators = [Coordinator]()
    var navigationController: UINavigationController
    var disposables = CompositeDisposable()

    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
        registerDependencies()
    }

    func start() {
        let viewModel = ContainerViewModel()
        let viewController = ContainerViewController(viewModel: viewModel)
        viewModel.start()
        navigationController.pushViewController(viewController, animated: false)

        disposables += viewModel.output.selCitySignal
            .observe(on: UIScheduler())
            .observeValues {[weak self] viewModel in
                self?.coordinateToCityDetail(viewModel)
            }
    }
    
    func coordinateToCityDetail(_ viewModel: WeatherInfoCellViewModel) {
        let detailViewModel = WeatherDetailViewModel(viewModel)
        let detailCoor = WeatherDetailCoordinator(navigationController, 
                                                  viewModel: detailViewModel)
        addChild(detailCoor)
        detailCoor.delegate = self
        coordinate(to: detailCoor)
    }
    
    func registerDependencies() {
        let assembly = AppServicesAssembly()
        applyAssembly(assembly)
    }
}

extension AppFlowCoordinator: ParentCoordinatorDelegate {}
