//
//  ContainerViewController.swift
//  WeatherForecast
//
//  Created by 小苹果 on 2023/10/19.
//

import UIKit
import WForecastUI
import WForecastComponents
import WForecastAPIClient

class ContainerViewController: NiblessViewController {
    
    var apiClient: WFAPIClientProtocol {
        return resolveComponent(WFAPIClientProtocol.self)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .purple

        apiClient.fetchWeatherInfo(city: 110101) { resultProducer in
            resultProducer.startWithResult { result in
                switch result {
                case .success(let data):
                    print("data: \(data.model.lives.count)")
                case .failure(let error):
                    print("error: \(error.localizedDescription)")
                }
            }
        }
    }
}
