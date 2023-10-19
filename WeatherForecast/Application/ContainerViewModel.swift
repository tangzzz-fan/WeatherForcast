//
//  ContainerViewModel.swift
//  WeatherForecast
//
//  Created by 小苹果 on 2023/10/19.
//

import Foundation

protocol ContainerViewModelType: AnyObject {
    var input: ContainerViewModelInput { get }
    var output: ContainerViewModelOutput { get }
}

protocol ContainerViewModelInput: AnyObject {
    
}

protocol ContainerViewModelOutput: AnyObject {
    
}

final class ContainerViewModel: ContainerViewModelType {
    
    var input: ContainerViewModelInput { return self }
    var output: ContainerViewModelOutput { return self }
    
}

extension ContainerViewModel: ContainerViewModelInput {}
extension ContainerViewModel: ContainerViewModelOutput {}

