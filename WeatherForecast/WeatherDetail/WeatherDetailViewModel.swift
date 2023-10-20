//
//  WeatherDetailViewModel.swift
//  WeatherForecast
//
//  Created by 小苹果 on 2023/10/20.
//

import ReactiveSwift

protocol WeatherDetailViewModelType: AnyObject {
    var input: WeatherDetailViewModelInput { get }
    var output: WeatherDetailViewModelOutput { get }
}

protocol WeatherDetailViewModelInput: AnyObject {
    func start()
    func backToListAction()
}

protocol WeatherDetailViewModelOutput: AnyObject {
    var backToListSignal: Signal<Void, Never> { get }
    var thumbnailModel: WeatherInfoCellViewModel { get }
}

class WeatherDetailViewModel: WeatherDetailViewModelType {
    
    var input: WeatherDetailViewModelInput { return self }
    var output: WeatherDetailViewModelOutput { return self }
    
    private let backToListPipe = Signal<Void, Never>.pipe()
    public var backToListSignal: Signal<Void, Never> { backToListPipe.output }
    
    var thumbnailModel: WeatherInfoCellViewModel
    
    init(_ viewModel: WeatherInfoCellViewModel) {
        self.thumbnailModel = viewModel
    }
    
    func start() {
        
    }
    
    func backToListAction() {
        backToListPipe.input.send(value: ())
    }
    
    deinit {
        debugPrint("\(type(of: self)) deinit")
    }
}

extension WeatherDetailViewModel: WeatherDetailViewModelInput {}
extension WeatherDetailViewModel: WeatherDetailViewModelOutput {}
