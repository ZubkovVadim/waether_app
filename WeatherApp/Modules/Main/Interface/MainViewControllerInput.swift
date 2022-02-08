//
//  MainViewControllerInput.swift
//  WeatherApp
//
//  Created by Sergey Balashov on 11.01.2022.
//

import Foundation

protocol MainViewControllerInput: AnyObject {
    // UpdateViews
    func updateWeather(weather: WeatherResponse)

    // Navigation
    func presentOnboardingModule()
}
