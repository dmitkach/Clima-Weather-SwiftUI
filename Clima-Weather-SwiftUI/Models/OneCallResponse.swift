//
//  OneCallWeather.swift
//  Clima-Weather-SwiftUI
//
//  Created by Dmitry Tkach on 22.09.2024.
//

import Foundation

struct OneCallResponse: Codable {
  let lat, lon: Double
  let timezone: String
  let current: CurrentResponse
  let hourly: [HourlyResponse]
  let daily: [DailyResponse]
}

struct CurrentResponse: Codable {
  let dt, sunrise, sunset: Int
  let temp, feelsLike: Double
  let pressure, humidity: Int
  let uvi: Double
  let clouds, visibility: Int?
  let windSpeed: Double
  let windDeg: Int
  let weather: [WeatherResponse]
  let rain: RainResponse?
  
  enum CodingKeys: String, CodingKey {
    case dt, sunrise, sunset, temp
    case feelsLike = "feels_like"
    case pressure, humidity, uvi, clouds, visibility
    case windSpeed = "wind_speed"
    case windDeg = "wind_deg"
    case weather, rain
  }
}

struct RainResponse: Codable {
  let the1H: Double?
  
  enum CodingKeys: String, CodingKey {
    case the1H = "1h"
  }
}

struct WeatherResponse: Codable {
  let id: Int
  let main, weatherDescription, icon: String
  
  enum CodingKeys: String, CodingKey {
    case id, main
    case weatherDescription = "description"
    case icon
  }
}

struct DailyResponse: Codable {
  let dt, sunrise, sunset: Int
  let temp: TempResponse
  let feelsLike: FeelsLikeResponse
  let pressure, humidity: Int
  let windSpeed: Double
  let windDeg: Int
  let weather: [WeatherResponse]
  let clouds: Int
  let rain: Double?
  let uvi: Double
  
  enum CodingKeys: String, CodingKey {
    case dt, sunrise, sunset, temp
    case feelsLike = "feels_like"
    case pressure, humidity
    case windSpeed = "wind_speed"
    case windDeg = "wind_deg"
    case weather, clouds, rain, uvi
  }
}

struct FeelsLikeResponse: Codable {
  let day, night, eve, morn: Double
}

struct TempResponse: Codable {
  let day, min, max, night: Double
  let eve, morn: Double
}

struct HourlyResponse: Codable {
  let dt: Int
  let temp, feelsLike: Double
  let pressure, humidity, clouds: Int
  let windSpeed: Double
  let windDeg: Int
  let weather: [WeatherResponse]
  let rain: RainResponse?
  
  enum CodingKeys: String, CodingKey {
    case dt, temp
    case feelsLike = "feels_like"
    case pressure, humidity, clouds
    case windSpeed = "wind_speed"
    case windDeg = "wind_deg"
    case weather, rain
  }
}
