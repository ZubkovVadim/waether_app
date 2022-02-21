//
//  MainViewPresenter.swift
//  WeatherApp
//
//  Created by Sergey Balashov on 11.01.2022.
//

import Foundation
import UIKit

class MainViewPresenter {
    weak var view: MainViewControllerInput?

    private let realmStorage: RealmStoraging
    private let geocoderService: GeocoderServing
    private let weatherService: WeatherServing

    init(
        realmStorage: RealmStoraging,
        geocoderService: GeocoderServing,
        weatherService: WeatherServing
    ) {
        self.realmStorage = realmStorage
        self.geocoderService = geocoderService
        self.weatherService = weatherService
    }
}

extension MainViewPresenter: MainViewControllerOutput {
    func viewDidLoad() {
//        getCityName()
        getCurrentWeather()
    }
}

private extension MainViewPresenter {
    func getCityName() {
        guard let coordinate = realmStorage.getLocation() else {
            return
        }

        geocoderService.getLocation(coordinate: coordinate) { result in
            switch result {
            case let .success(response):
                print("cityName", response.cityName)
                // TODO: Update view

            case let .failure(error):
                print("error", error)
            }
        }
    }

    func getCurrentWeather() {
        guard let coordinate = realmStorage.getLocation() else {
            return
        }

        weatherService.getCurrentWeather(coordinate: coordinate) { [weak self] result in
            switch result {
            case let .success(response):
                self?.updateDataSource(response: response)
            case let .failure(error):
                print("error", error)
            }
        }
    }
    
    func updateDataSource(response: WeatherResponse) {
        view?.updateTitle(response.name)
        
        // подготовить dataSource для view
        var dataSource: [MainViewController.DataType] = []
        
        // Наполнить dataSource
        dataSource.append(.header(viewModel: buildHeaderMainCellViewModel(weatherResponse: response)))
        
        view?.updateWeather(dataSource: dataSource)
    }
    
    func buildHeaderMainCellViewModel(weatherResponse: WeatherResponse) -> HeaderMainCellViewModel {
        let todayValue = Date().string(format: "HH:mm', 'E dd MMMM")
        
        return HeaderMainCellViewModel(
            minDegrees: weatherResponse.main.tempMin,
            maxDegrees: weatherResponse.main.tempMax,
            currentDegrees: weatherResponse.main.temp,
            weatherDescription: weatherResponse.weather.first?.description,
            sunsetTime: weatherResponse.sys.sunset.string(format: "HH:mm"),
            sunriseTime: weatherResponse.sys.sunrise.string(format: "HH:mm"),
            cloudValue: weatherResponse.clouds.all.string,
            windValue: weatherResponse.wind?.speed,
            humidityValue: weatherResponse.main.humidity,
            todayValue: todayValue
        )
    }
}
