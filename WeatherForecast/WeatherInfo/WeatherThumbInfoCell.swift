//
//  WeatherThumbInfoCell.swift
//  WeatherForecast
//
//  Created by 小苹果 on 2023/10/20.
//

import UIKit
import Anchorage
import WForecastUI

class WeatherThumbInfoCell: NiblessTableViewCell {
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configureViews()
        configureLayout()
    }
    
    func configureViews() {
        contentView.addSubview(containers)
        containers.addSubview(contentSV)
    }
    
    func configureLayout() {
        containers.horizontalAnchors == contentView.horizontalAnchors
        containers.verticalAnchors == contentView.verticalAnchors + 4
        
        contentSV.horizontalAnchors == containers.horizontalAnchors + 16
        contentSV.topAnchor == containers.topAnchor + 4
        contentSV.bottomAnchor == containers.bottomAnchor - 8
    }
    
    lazy var cityName: UILabel = {
        let cityName = UILabel()
        cityName.text = "城市"
        cityName.font = UIFont.systemFont(ofSize: 20)
        return cityName
    }()
    
    lazy var reporttime: UILabel = {
        let reporttime = UILabel()
        reporttime.text = "报告时间"
        reporttime.font = UIFont.systemFont(ofSize: 14)
        return reporttime
    }()
    
    lazy var leftTopCorner: UIStackView = {
        let sv = UIStackView(arrangedSubviews: [cityName, reporttime])
        sv.axis = .vertical
        sv.alignment = .leading
        sv.spacing = 4
        sv.distribution = .fill
        return sv
    }()
    
    lazy var temperature: UILabel = {
        let temperature = UILabel()
        temperature.text = "气温"
        temperature.font = UIFont.systemFont(ofSize: 24)
        return temperature
    }()
    
    lazy var topSV: UIStackView = {
        let sv = UIStackView(arrangedSubviews: [leftTopCorner, temperature])
        sv.axis = .horizontal
        sv.distribution = .fill
        sv.alignment = .center
        return sv
    }()
    
    lazy var weatherInfo: UILabel = {
        let info = UILabel()
        info.text = "天气简况"
        info.font = UIFont.systemFont(ofSize: 14)
        return info
    }()

    // live
    // winddirection + windpower
    lazy var windpower: UILabel = {
        let windpower = UILabel()
        windpower.text = "风力"
        windpower.font = UIFont.systemFont(ofSize: 14)
        return windpower
    }()
    
    lazy var humidity: UILabel = {
        let humidity = UILabel()
        humidity.text = "湿度"
        humidity.font = UIFont.systemFont(ofSize: 14)
        return humidity
    }()
    
    // cast
    lazy var maxTemp: UILabel = {
        let maxTemp = UILabel()
        maxTemp.text = "最高"
        maxTemp.isHidden = true
        maxTemp.font = UIFont.systemFont(ofSize: 14)
        return maxTemp
    }()
    
    lazy var minTemp: UILabel = {
        let minTemp = UILabel()
        minTemp.text = "最低"
        minTemp.isHidden = true
        minTemp.font = UIFont.systemFont(ofSize: 14)
        return minTemp
    }()
    
    lazy var rightBottomCorner: UIStackView = {
        let sv = UIStackView(arrangedSubviews: [windpower, humidity, maxTemp, minTemp])
        sv.axis = .horizontal
        sv.distribution = .fill
        sv.alignment = .center
        sv.spacing = 8
        return sv
    }()
    
    lazy var bottomSV: UIStackView = {
        let sv = UIStackView(arrangedSubviews: [weatherInfo, rightBottomCorner])
        sv.axis = .horizontal
        sv.distribution = .fill
        sv.alignment = .center
        return sv
    }()
    
    lazy var contentSV: UIStackView = {
        let sv = UIStackView(arrangedSubviews: [topSV, bottomSV])
        sv.axis = .vertical
        sv.distribution = .fillProportionally
        sv.alignment = .fill
        return sv
    }()
    
    lazy var containers: UIView = {
        let view = UIView()
        view.backgroundColor = .lightGray
        view.layer.cornerRadius = 20
        return view
    }()
}

extension WeatherThumbInfoCell: ViewModelConfigurable {
    
    typealias ViewModel = WeatherInfoCellViewModel
    
    func configure(_ viewModel: ViewModel) {
        cityName.text = viewModel.baseInfo?.city ?? "--"
        reporttime.text = viewModel.reportTimeStr
        
        if let live = viewModel.live {
            temperature.text = live.temperature.temperatureString
            weatherInfo.text = live.weather
            windpower.text = "\(live.winddirection): \(live.windpower)级"
            humidity.text = live.humidity
            
            windpower.isHidden = false
            humidity.isHidden = false
            
            maxTemp.isHidden = true
            minTemp.isHidden = true
        } else {
            if let todayCast = viewModel.todayCast {
                temperature.text = todayCast.daytemp.temperatureString
                weatherInfo.text = todayCast.dayweather
                windpower.text = todayCast.daypower
                
                windpower.isHidden = true
                humidity.isHidden = true
                
                maxTemp.isHidden = false
                minTemp.isHidden = false
                
                maxTemp.text = "最高: \(todayCast.daytempfloat.temperatureString)"
                minTemp.text = "最低: \(todayCast.nighttempfloat.temperatureString)"
            }
        }
    }
}
