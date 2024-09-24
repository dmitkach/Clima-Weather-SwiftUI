//
//  DataManager.swift
//  Clima-Weather-SwiftUI
//
//  Created by Dmitry Tkach on 11.09.2024.
//

import Foundation
import Combine

protocol WeatherFetcher {
    func fetchWeather(lat: Double, lon: Double) -> AnyPublisher<Weather, Error>
}

class DataManager {
    private let session: URLSession
    
    init(session: URLSession = .init(configuration: .default)) {
        self.session = session
    }
}

extension DataManager: WeatherFetcher {
    func fetchWeather(lat: Double, lon: Double) -> AnyPublisher<Weather, Error> {
        guard let url = createWeatherRequestComponents(lat: lat, lon: lon).url else {
            return Fail(error: URLError(.badURL))
                .eraseToAnyPublisher()
        }
        
        return session.dataTaskPublisher(for: URLRequest(url: url))
            .map{ $0.data }
            .decode(type: OneCallResponse.self, decoder: JSONDecoder())
            .map { response in
                return Weather.convert(fromResponse: response)
            }
            .eraseToAnyPublisher()
        
    }
}

private extension DataManager {
    struct OpenWeatherAPI {
        static let scheme: String = "https"
        static let host: String = "api.openweathermap.org"
        static let path: String = "/data/3.0/onecall"
        static var key: String = "9782d9017fa7461dbe2de00741bf2981"
    }
    
    private func createWeatherRequestComponents(lat: Double, lon: Double) -> URLComponents {
        var components = URLComponents()
        
        components.scheme = OpenWeatherAPI.scheme
        components.host = OpenWeatherAPI.host
        components.path = OpenWeatherAPI.path
        
        components.queryItems = [
            .init(name: "lat", value: String(lat)),
            .init(name: "lon", value: String(lon)),
            .init(name: "appid", value: OpenWeatherAPI.key),
            .init(name: "units", value: "metric")
        ]
        
        print(components.url?.absoluteString ?? "URL is nil")
        
        return components
    }
}
