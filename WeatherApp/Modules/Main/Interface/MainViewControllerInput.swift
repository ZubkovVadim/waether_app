//
//  MainViewControllerInput.swift
//  WeatherApp
//
//  Created by Sergey Balashov on 11.01.2022.
//

import Foundation

protocol MainViewControllerInput: AnyObject {
    // UpdateViews
    func updateTitle(_ title: String?)
    func updateWeather(dataSource: [MainViewController.DataType])
    
    // Erros
    func showAlert(error: Error)

    // Navigation
    func presentOnboardingModule()
}
