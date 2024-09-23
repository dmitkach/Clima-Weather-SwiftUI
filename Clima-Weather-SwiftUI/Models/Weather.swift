//
//  Weather.swift
//  Clima-Weather-SwiftUI
//
//  Created by Dmitry Tkach on 23.09.2024.
//

import Foundation
import SwiftUI

struct Weather: Codable {
    let lat, lon: Double
    let timezone: String
    let current: CurrentWeather
    let hourly: [HourlyWeather]
    let daily: [DailyWeather]

    static func convert(fromResponse response: OneCallResponse) -> Weather {
        Weather(lat: response.lat,
                lon: response.lon,
                timezone: response.timezone,
                current: .convert(fromResponse: response.current),
                hourly: response.hourly.map { .convert(fromResponse: $0) },
                daily: response.daily.map { .convert(fromResponse: $0) })
    }
    
    enum CodingKeys: String, CodingKey {
        case lat, lon, timezone
        case current, hourly, daily
    }
}

struct CurrentWeather: Codable {
    let dt: Date
    let sunrise, sunset: Date
    let temp, feelsLike: Double
    let pressure, humidity: Int
    let uvi: Double
    let windSpeed: Double
    let windDeg: Int
    let weather: [WeatherElement]

    static func convert(fromResponse response: CurrentResponse) -> CurrentWeather {
        CurrentWeather(dt: Date(timeIntervalSince1970: TimeInterval(response.dt)),
                sunrise: Date(timeIntervalSince1970: TimeInterval(response.sunrise)),
                sunset: Date(timeIntervalSince1970: TimeInterval(response.sunset)),
                temp: response.temp,
                feelsLike: response.feelsLike,
                pressure: response.pressure,
                humidity: response.humidity,
                uvi: response.uvi,
                windSpeed: response.windSpeed,
                windDeg: response.windDeg,
                weather: response.weather.map { .convert(fromResponse: $0) })
    }
    
    enum CodingKeys: String, CodingKey {
        case dt, sunrise, sunset, temp
        case feelsLike = "feels_like"
        case pressure, humidity
        case uvi
        case windSpeed = "wind_speed"
        case windDeg = "wind_deg"
        case weather
    }
}

struct WeatherElement: Codable {
    let id: Int
    let main, description: String
    var weatherIconID: String
    var weatherIcon: Image? {
        switch weatherIconID {
        case "01d": return Image(systemName: "sun.max")
        case "01n": return Image(systemName: "moon")
        case "02d": return Image(systemName: "cloud.sun")
        case "02n": return Image(systemName: "cloud.moon")
        case "03d", "03n", "04d", "04n": return Image(systemName: "cloud")
        case "09d", "09n": return Image(systemName: "cloud.rain")
        case "10d": return Image(systemName: "cloud.sun.rain")
        case "10n": return Image(systemName: "cloud.moon.rain")
        case "11d", "11n": return Image(systemName: "cloud.bolt.rain")
        case "13d", "13n": return Image(systemName: "cloud.snow")
        case "50d", "50n": return Image(systemName: "cloud.fog")
        default: return Image(systemName: "sun.max")
        }
    }
    
    static func convert(fromResponse response: WeatherResponse) -> WeatherElement {
        WeatherElement(id: response.id,
                       main: response.main,
                       description: response.weatherDescription,
                       weatherIconID: response.icon)
    }
}

struct DailyWeather: Codable, Identifiable {
    let id = UUID()
    let dt, sunrise, sunset: Date
    let temp: Temp
    let weather: [WeatherElement]

    static func convert(fromResponse response: DailyResponse) -> DailyWeather {
        DailyWeather(dt: Date(timeIntervalSince1970: TimeInterval(response.dt)),
              sunrise: Date(timeIntervalSince1970: TimeInterval(response.sunrise)),
              sunset: Date(timeIntervalSince1970: TimeInterval(response.sunset)),
              temp: Temp.init(day: response.temp.day,
                              min: response.temp.min,
                              max: response.temp.max,
                              night: response.temp.night,
                              eve: response.temp.eve,
                              morn: response.temp.morn),
              weather: response.weather.map { .convert(fromResponse: $0) })
    }
    
    enum CodingKeys: String, CodingKey {
        case dt, sunrise, sunset
        case temp
        case weather
    }
}

struct HourlyWeather: Codable {
    let time: Date
    let actualTemp, feelsLikeTemp: Double
  
    let weather: [WeatherElement]
  
    static func convert(fromResponse response: HourlyResponse) -> HourlyWeather {
        HourlyWeather(time: Date(timeIntervalSince1970: TimeInterval(response.dt)),
               actualTemp: response.temp,
               feelsLikeTemp: response.feelsLike,
               weather: response.weather.map { .convert(fromResponse: $0) })
  }
}

struct Temp: Codable {
    let day, min, max, night: Double
    let eve, morn: Double
}
