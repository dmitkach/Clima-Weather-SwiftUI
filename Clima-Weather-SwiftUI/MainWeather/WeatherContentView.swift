//
//  WeatherContentView.swift
//  Clima-Weather-SwiftUI
//
//  Created by Dmitry Tkach on 11.09.2024.
//

import SwiftUI

struct WeatherContentView: View {
    @ObservedObject var viewModel: WeatherViewModel
    
    init(viewModel: WeatherViewModel) {
        self.viewModel = viewModel
        viewModel.fetchWeather(forCity: viewModel.searchText)
    }
    
    var body: some View {
        ZStack {
            Color(.systemBackground)
                .edgesIgnoringSafeArea(.all)
            VStack(spacing: 32) {
                TextField("Enter City Name", text: $viewModel.searchText)
                    .onSubmit {
                        viewModel.fetchWeather(forCity: viewModel.searchText)
                    }
                    .padding(.vertical, 10)
                    .padding(.horizontal)
                    .background(Color(.secondarySystemBackground))
                    .cornerRadius(12)
                    .padding(.all)
                
                currentWeatherView
                
                Spacer()
                ScrollView(.vertical, showsIndicators: false) {
                    VStack{
                        if let dailyViews = viewModel.weather?.daily{
                            ForEach(dailyViews) { dailyWeather in
                                DailyWeatherView(viewModel: .init(daySummary: dailyWeather))
                            }
                        } else {
                            DailyWeatherView(viewModel: .init(daySummary: nil))
                        }
                    }
                } .padding(.horizontal)
                    .padding(.top)
                
            }
        }
    }
    
    private var currentWeatherView: some View {
        if let _ = viewModel.weather {
            return AnyView(
                HStack {
                    VStack(spacing: 4) {
                        Text(viewModel.currentTemperatureDescription)
                            .font(.headline)
                            .fontWeight(.medium)
                        HStack {
                            viewModel.currentWeatherIcon
                                .imageScale(.small)
                            Text("\(viewModel.currentTemperatureString)")
                                .fontWeight(.semibold)
                        }.font(.system(size: 64))
                            .frame(maxWidth: .infinity)
                        HStack(spacing: 16) {
                            Text("Feels like \(viewModel.feelsLikeTemperatureString)")
                                .foregroundColor(.secondary)
                        }
                    }
                })
        } else {
            return AnyView(EmptyView())
        }
    }
}

#Preview {
    WeatherContentView(viewModel: WeatherViewModel())
}
