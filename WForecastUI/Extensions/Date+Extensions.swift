//
//  Date+Extensions.swift
//  WForecastUI
//
//  Created by 小苹果 on 2023/10/20.
//

import Foundation

public extension Date {
    static let minuteFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "HH:mm"
        return formatter
    }()

    init(serverDateString: String) {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        self = formatter.date(from: serverDateString) ?? Date()
    }

    var minuteString: String {
        return Date.minuteFormatter.string(from: self)
    }
}
