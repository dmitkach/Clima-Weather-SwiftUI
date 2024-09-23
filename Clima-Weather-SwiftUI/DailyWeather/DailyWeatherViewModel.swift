//
//  DailyWeatherViewModel.swift
//  Clima-Weather-SwiftUI
//
//  Created by Dmitry Tkach on 23.09.2024.
//

import Foundation
import SwiftUI

class DailyWeatherViewModel {
    private let dailyWeather: DailyWeather?
    
    var id = UUID()
    
    var day: String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "EEEE"
        if let weather = dailyWeather {
            return dateFormatter.string(from: weather.dt)
        } else {
            return dateFormatter.string(from: Date.now)
        }
    }
    
    var maxTempFmt: String {
        if let weather = dailyWeather {
            String(format: "%.0fº", weather.temp.max)
        } else {
            String("--º")
        }
    }
    
    var minTempFmt: String {
        if let weather = dailyWeather {
            String(format: "%.0fº", weather.temp.min)
        } else {
            String("--º")
        }
    }
    
    var icon: Image? {
        if let weather = dailyWeather {
            guard let icon = weather.weather.first?.weatherIcon else { return nil }
            return icon
        } else {
            return nil
        }
    }
    
    init(daySummary: DailyWeather?) {
      self.dailyWeather = daySummary
    }
}
