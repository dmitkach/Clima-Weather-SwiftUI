//
//  Clima_Weather_SwiftUIApp.swift
//  Clima-Weather-SwiftUI
//
//  Created by Dmitry Tkach on 11.09.2024.
//

import SwiftUI

@main
struct Clima_Weather_SwiftUIApp: App {
    var body: some Scene {
        WindowGroup {
            // Хммм а с перерисовками все окей? Если ObservedObject, то нужно, чтобы кто-то держал ViewModel
            WeatherContentView(viewModel: WeatherViewModel())
        }
    }
}
