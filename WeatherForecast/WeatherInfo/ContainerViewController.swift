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

    private var viewModel: ContainerViewModelType
    
    init(viewModel: ContainerViewModelType) {
        self.viewModel = viewModel
        super.init()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .purple

    }
}
