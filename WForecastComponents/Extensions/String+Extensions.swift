//
//  String+Extensions.swift
//  WForecastComponents
//
//  Created by 小苹果 on 2023/10/20.
//

import Foundation

public extension String {
    var temperatureString: String {
        guard let value = Double(self) else { return self }
        let temperatureMeasurement = Measurement(value: value, unit: UnitTemperature.celsius)
        let temperatureFormatter = MeasurementFormatter()
        temperatureFormatter.numberFormatter.maximumFractionDigits = 0
        temperatureFormatter.unitOptions = .providedUnit
        return temperatureFormatter.string(from: temperatureMeasurement)
    }
}
