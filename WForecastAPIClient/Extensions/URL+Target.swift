//
//  URL+Target.swift
//  WForecastAPIClient
//
//  Created by 小苹果 on 2023/10/19.
//

import Foundation
import Moya

public extension URL {

    /// Initialize URL from Moya's `TargetType`.
    init<T: TargetType>(wfTarget: T) throws {
        let targetPath = wfTarget.path
        if targetPath.isEmpty {
            self = wfTarget.baseURL
        } else {
            var path = wfTarget.path
            if !path.hasPrefix("/") {
                path = "/" + path
            }
            let urlString = wfTarget.baseURL.absoluteString + path
            if let url = URL(string: urlString) {
                self = url
            } else {
                throw "Invalid url string:\(urlString)"
            }
        }
    }
}
