//
//  WeatherDetailCoordinator.swift
//  WeatherForecast
//
//  Created by 小苹果 on 2023/10/20.
//

import UIKit
import ReactiveSwift

class WeatherDetailCoordinator: ParentCoordinator, HasRootViewController {
    let disposables = CompositeDisposable()
    weak var delegate: ParentCoordinatorDelegate?
    
    var rootViewController: UIViewController {
        cityDetailViewController
    }
    
    var navigationController: UINavigationController?
    var childCoordinators = [Coordinator]()
    var cityDetailViewController: WeatherDetailViewController
    var viewModel: WeatherDetailViewModel
    
    init(_ navigationViewController: UINavigationController,
         viewModel: WeatherDetailViewModel) {
        self.navigationController = navigationViewController
        self.viewModel = viewModel
        self.cityDetailViewController = WeatherDetailViewController(viewModel: viewModel)
        
        disposables += viewModel.output.backToListSignal
            .observe(on: UIScheduler())
            .observeValues {[weak self] _ in
                guard let self = self else { return }
                self.navigationController?.popViewController(animated: true)
                self.delegate?.didFinishChildCoordinator(self)
        }
    }
    
    func start() {
        navigationController?.pushViewController(cityDetailViewController, animated: true)
    }
    
    deinit {
        disposables.dispose()
        debugPrint("\(type(of: self)) deinit")
    }
}
