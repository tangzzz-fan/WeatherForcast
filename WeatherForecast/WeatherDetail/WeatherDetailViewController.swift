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
    
    private struct Constants {
        static let backButtonSize = CGSize(width: 64, height: 44)
        static let spacing: CGFloat = 16
    }
    
    private var viewModel: WeatherDetailViewModel
    
    init(viewModel: WeatherDetailViewModel) {
        self.viewModel = viewModel
        super.init()
        configureViewModel()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        backButton.sizeAnchors == Constants.backButtonSize
        view.addSubview(backButton)
        backButton.leadingAnchor == view.leadingAnchor
        backButton.topAnchor == view.topAnchor + Constants.backButtonSize.height
        
        view.addSubview(titleLabel)
        titleLabel.centerYAnchor == backButton.centerYAnchor
        titleLabel.heightAnchor == backButton.heightAnchor
        titleLabel.centerXAnchor == view.centerXAnchor
        
        view.addSubview(contentSV)
        
        contentSV.topAnchor == titleLabel.bottomAnchor + Constants.spacing
        contentSV.horizontalAnchors == view.horizontalAnchors
        contentSV.heightAnchor >= 300
    }
    
    func configureViewModel() {
        let infoModel = viewModel.output.thumbnailModel
        cityName.text = infoModel.baseInfo?.city
        dayTemp.text = infoModel.todayCast?.daytemp.temperatureString
        
        minTemp.text = "最低: \(infoModel.todayCast?.nighttemp.temperatureString ?? "")"
        maxTemp.text = "最高: \(infoModel.todayCast?.daytemp.temperatureString ?? "")"
        
        dayweather.text = "白天温度: \(infoModel.todayCast?.dayweather ?? "--")"
        nightweather.text = "夜间温度: \(infoModel.todayCast?.nightweather ?? "--")"
        
        daywindpower.text = "白天风力: " + (infoModel.tomorrowCast?.daywind ?? "--")
                                        + (infoModel.tomorrowCast?.daypower ?? "--")
        nightwindpower.text = "夜间风力: " + (infoModel.tomorrowCast?.nightwind ?? "--")
                                        + (infoModel.tomorrowCast?.nightpower ?? "--")
    }
    
    lazy var backButton = {
        let btn = UIButton()
        btn.backgroundColor = .white
        btn.setTitle("X", for: .normal)
        btn.titleLabel?.textAlignment = .left
        btn.setTitleColor(UIColor.blue, for: .normal)
        btn.addTarget(self, action: #selector(backAction), for: .touchUpInside)
        return btn
    }()
    
    @objc func backAction() {
        viewModel.input.backToListAction()
    }
    
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.text = "城市一周天气"
        label.font = UIFont.systemFont(ofSize: 18)
        return label
    }()
    
    lazy var cityName: UILabel = {
        let label = UILabel()
        label.text = "--"
        label.font = UIFont.systemFont(ofSize: 24)
        return label
    }()
    
    lazy var dayTemp: UILabel = {
        let label = UILabel()
        label.text = "--"
        label.font = UIFont.systemFont(ofSize: 50)
        return label
    }()
    
    lazy var minTemp: UILabel = {
        let label = UILabel()
        label.text = "--"
        label.font = UIFont.systemFont(ofSize: 18)
        return label
    }()
    
    lazy var maxTemp: UILabel = {
        let label = UILabel()
        label.text = "--"
        label.font = UIFont.systemFont(ofSize: 18)
        return label
    }()
    
    lazy var mmTempSV: UIStackView = {
        let sv = UIStackView(arrangedSubviews: [minTemp, maxTemp])
        sv.axis = .horizontal
        sv.spacing = Constants.spacing
        sv.alignment = .center
        sv.distribution = .fill
        return sv
    }()
    
    lazy var upSV: UIStackView = {
        let sv = UIStackView(arrangedSubviews: [cityName, dayTemp, mmTempSV])
        sv.axis = .vertical
        sv.distribution = .fill
        sv.alignment = .center
        sv.spacing = Constants.spacing
        return sv
    }()
    
    lazy var dayweather: UILabel = {
        let label = UILabel()
        label.text = "--"
        label.font = UIFont.systemFont(ofSize: 18)
        return label
    }()
    
    lazy var nightweather: UILabel = {
        let label = UILabel()
        label.text = "--"
        label.font = UIFont.systemFont(ofSize: 18)
        return label
    }()
    
    lazy var weatherSV: UIStackView = {
        let sv = UIStackView(arrangedSubviews: [dayweather, nightweather])
        sv.axis = .horizontal
        sv.spacing = Constants.spacing
        sv.alignment = .center
        sv.distribution = .fillProportionally
        return sv
    }()
    
    lazy var daywindpower: UILabel = {
        let label = UILabel()
        label.text = "--"
        label.font = UIFont.systemFont(ofSize: 18)
        return label
    }()
    
    lazy var nightwindpower: UILabel = {
        let label = UILabel()
        label.text = "--"
        label.font = UIFont.systemFont(ofSize: 18)
        return label
    }()
    
    lazy var windSV: UIStackView = {
        let sv = UIStackView(arrangedSubviews: [daywindpower, nightwindpower])
        sv.distribution = .fillProportionally
        sv.alignment = .center
        sv.axis = .horizontal
        sv.spacing = Constants.spacing
        return sv
    }()
    
    lazy var contentSV: UIStackView = {
        let sv = UIStackView(arrangedSubviews: [upSV, weatherSV, windSV])
        sv.axis = .vertical
        sv.distribution = .fillProportionally
        sv.alignment = .center
        sv.spacing = Constants.spacing
        return sv
    }()
    
    deinit {
        debugPrint("\(type(of: self)) deinit")
    }

}
