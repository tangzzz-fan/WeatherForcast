//
//  WeatherDetailViewController.swift
//  WeatherForecast
//
//  Created by 小苹果 on 2023/10/20.
//

import UIKit
import WForecastUI
import Anchorage

class WeatherDetailViewController: NiblessViewController {
    
    private var viewModel: WeatherDetailViewModel
    
    init(viewModel: WeatherDetailViewModel) {
        self.viewModel = viewModel
        super.init()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .random
        
        navigationController?.setNavigationBarHidden(true, animated: false)
        
        backButton.sizeAnchors == CGSize(width: 100, height: 44)
        view.addSubview(backButton)
        backButton.leadingAnchor == view.leadingAnchor + 16
        backButton.topAnchor == view.topAnchor + 44
    }
    
    lazy var backButton = {
        let btn = UIButton()
        btn.setTitle("返回", for: .normal)
        btn.titleLabel?.textAlignment = .left
        btn.setTitleColor(UIColor.blue, for: .normal)
        btn.addTarget(self, action: #selector(backAction), for: .touchUpInside)
        return btn
    }()
    
    @objc func backAction() {
        viewModel.input.backToListAction()
    }
    
    deinit {
        debugPrint("\(type(of: self)) deinit")
    }

}
