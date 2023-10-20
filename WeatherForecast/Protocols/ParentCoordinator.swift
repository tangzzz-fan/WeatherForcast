//
//  ParentCoordinator.swift
//  WeatherForecast
//
//  Created by 小苹果 on 2023/10/20.
//

import UIKit
import ReactiveSwift

protocol ParentCoordinator: Coordinator {
    
    var disposables: CompositeDisposable { get }
    
    var childCoordinators: [Coordinator] { get set }
    
    func addChild(_ coordinator: Coordinator)
    
    func removeChild(_ coordinator: Coordinator)
    
    func removeAllChildCoordinators()

}

protocol ParentCoordinatorDelegate: AnyObject {
    func didFinishChildCoordinator(_ childCoordinator: Coordinator)
}

protocol HasParentCoordinatorDelegate {
    var delegate: ParentCoordinatorDelegate? { get set }
}

extension ParentCoordinator {
    
    func addChild(_ coordinator: Coordinator) {
        childCoordinators.append(coordinator)
    }
    
    func removeChild(_ coordinator: Coordinator) {
        childCoordinators.removeAll(where: { $0 === coordinator })
    }
    
    func removeAllChildCoordinators() {
        childCoordinators.removeAll()
    }
}

extension ParentCoordinatorDelegate where Self: ParentCoordinator {
    
    func didFinishChildCoordinator(_ childCoordinator: Coordinator) {
        removeChild(childCoordinator)
    }
    
}

extension ParentCoordinator where Self: ParentCoordinatorDelegate {
    
    /// This method should be called to dismiss all modal coordinators before trying to present new one
    func finishModalCoordinators(_ completion: (() -> Void)? = nil) {
        for coordinator in childCoordinators {
            coordinator.finish(completion)
            didFinishChildCoordinator(coordinator)
        }
    }
    
}
