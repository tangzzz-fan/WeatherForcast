//
//  ContainerViewModel.swift
//  WeatherForecast
//
//  Created by 小苹果 on 2023/10/19.
//

import ReactiveSwift

protocol ContainerViewModelType: AnyObject {
    var input: ContainerViewModelInput { get }
    var output: ContainerViewModelOutput { get }
}

protocol ContainerViewModelInput: AnyObject {
    func start()
}

protocol ContainerViewModelOutput: AnyObject {
    var datasourceSignal: Signal<[WeatherInfoCellViewModel], Never> { get }
}

final class ContainerViewModel: ContainerViewModelType {
    
    var input: ContainerViewModelInput { return self }
    var output: ContainerViewModelOutput { return self }

    private let datasourcePipe = Signal<[WeatherInfoCellViewModel], Never>.pipe()
    public var datasourceSignal: Signal<[WeatherInfoCellViewModel], Never> { datasourcePipe.output }
    
    private let disposables = CompositeDisposable()
    private var dataLoader: WeatherInfoDataLoader
    private var cityIndexs: [Int] = [110000, 210100, 310000, 320500, 440100, 440300]
    
    init() {
        self.dataLoader = WeatherInfoDataLoader(cityIndexs: cityIndexs)
        
        disposables += dataLoader.dataSource
            .observeValues { [weak self] results in
                guard let self = self else { return }
                let weatherInfoResults = results.map { dict in
                    WeatherInfoCellViewModel(dict.value)
                }
                self.datasourcePipe.input.send(value: weatherInfoResults)
            }
    }
    
    func start() {
        dataLoader.start()
    }
    
    deinit {
        disposables.dispose()
        debugPrint("\(type(of: self)) deinit")
    }
}

extension ContainerViewModel: ContainerViewModelInput {}
extension ContainerViewModel: ContainerViewModelOutput {}

