//
//  SceneDelegate.swift
//  WeatherForecast
//
//  Created by 小苹果 on 2023/10/19.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?
    var appFlowCoordinator: AppFlowCoordinator?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, 
               options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        
        let window = UIWindow(windowScene: windowScene)
        
        let navigationController = UINavigationController()

        window.rootViewController = navigationController
        
        appFlowCoordinator = AppFlowCoordinator(navigationController: navigationController)
        
        appFlowCoordinator?.start()
        
        self.window = window
        window.makeKeyAndVisible()
    }

}

