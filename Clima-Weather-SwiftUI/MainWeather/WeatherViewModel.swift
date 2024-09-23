//
//  WeatherViewModel.swift
//  Clima-Weather-SwiftUI
//
//  Created by Dmitry Tkach on 21.09.2024.
//

import SwiftUI
import Combine
import CoreLocation

class WeatherViewModel: ObservableObject {
    @Published var weather: Weather?
    @Published var searchText: String = "Moscow"
    
    var dataManager: DataManager = .init()
    var cancellable = [AnyCancellable]()
    
    var currentTemperatureString: String {
        guard let temp = weather?.current.temp else { return "--º" }
        
        return String(format: "%.0fº", temp)
    }
    
    var currentTemperatureDescription: String {
        guard let description = weather?.current.weather.first?.description else {
        return ""
      }
      return description.localizedCapitalized
    }
    
    var feelsLikeTemperatureString: String {
        guard let temp = weather?.current.feelsLike else { return "--º" }
      return String(format: "%.0fº", temp)
    }
    
    var currentWeatherIcon: Image? {
        weather?.current.weather.first?.weatherIcon
    }
    
    func fetchWeather(forCity city: String) {
        fetchCoordinates(forCity: city) { [self] coordinates in
            dataManager.fetchWeather(lat: coordinates.latitude, lon: coordinates.longitude)
                .receive(on: DispatchQueue.main)
                .sink(receiveCompletion: { [weak self] value in
                    switch value {
                    case .failure(let error):
                        self?.weather = nil
                        print(error)
                    case .finished:
                        break
                    }
                }, receiveValue: { [weak self] weather in
                    self?.weather = weather
                })
                .store(in: &cancellable)
        }
    }
    
    func fetchCoordinates(forCity city: String, complition: @escaping (CLLocationCoordinate2D) -> ()) {
        CLGeocoder().geocodeAddressString(city, completionHandler: { (placemarks, error) in
            if let error = error {
                print(error.localizedDescription)
            } else if let placemark = placemarks?.first {
                let coordinate = placemark.location?.coordinate
                
                
                if let coordinate = coordinate {
                    complition(coordinate)
                } else {
                    complition(CLLocationCoordinate2D(latitude: 55.755, longitude: 37.6173))
                }
            }
        })
    }
}
