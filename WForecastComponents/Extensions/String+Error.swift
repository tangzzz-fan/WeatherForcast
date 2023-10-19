//
//  String+Error.swift
//  WForecastComponents
//
//  Created by 小苹果 on 2023/10/19.
//

import Foundation

extension String: Error { }

extension String: LocalizedError {
    
    public var errorDescription: String? {
        return self
    }

}
