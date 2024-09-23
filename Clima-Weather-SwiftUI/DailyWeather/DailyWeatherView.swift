//
//  DailyWeatherView.swift
//  Clima-Weather-SwiftUI
//
//  Created by Dmitry Tkach on 23.09.2024.
//

import SwiftUI

struct DailyWeatherView: View {
    private let viewModel: DailyWeatherViewModel
    
    init(viewModel: DailyWeatherViewModel) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        HStack {
            Text(viewModel.day)
                .fontWeight(.medium)
            Spacer()
            Text("\(viewModel.maxTempFmt) / \(viewModel.minTempFmt)")
                .fontWeight(.light)
            viewModel.icon
                .imageScale(.large)
                .foregroundColor(.secondary)
        }.padding(.horizontal)
            .padding(.vertical, 22)
            .background(Color.init(.secondarySystemBackground))
            .cornerRadius(10)
    }
}

#Preview {
    DailyWeatherView(viewModel: DailyWeatherViewModel(
        daySummary: .init(dt: Date(timeIntervalSince1970: 1727082000),
                          sunrise: Date(timeIntervalSince1970: 1727061427),
                          sunset: Date(timeIntervalSince1970: 1727105194),
                          temp: Temp(day: 14, min: 8, max: 15, night: 8, eve: 10, morn: 11), weather: [.init(id: 125, main: "Clouds", description: "scattered clouds", weatherIconID: "03d")])))
}
