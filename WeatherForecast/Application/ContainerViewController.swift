//
//  ContainerViewController.swift
//  WeatherForecast
//
//  Created by 小苹果 on 2023/10/19.
//

import UIKit

class ContainerViewController: UIViewController {
    
    init() {
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .purple
        self.title = "Registration"
    }
}
