//
//  ViewModelConfigurable.swift
//  WForecastUI
//
//  Created by 小苹果 on 2023/10/20.
//

import UIKit

public protocol ViewModelConfigurable {
    
    associatedtype ViewModel = Any
    
    func configure(_ viewModel: ViewModel)
    func configure(for expectedWidth: CGFloat)
}

public extension ViewModelConfigurable {
    func configure(_ viewModel: ViewModel) { }
    func configure(for expectedWidth: CGFloat) { }
}

