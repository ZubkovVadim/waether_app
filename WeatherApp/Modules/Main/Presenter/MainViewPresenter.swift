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
        loadWeather()
    }
}

private extension MainViewPresenter {
    func loadWeather() {
        guard let coordinate = realmStorage.getLocation() else {
            return
        }
        
        let dispatchGroup = DispatchGroup()
        var currentWeather: WeatherResponse?
        var hoursWeather: HoursResponse?
        
        dispatchGroup.enter() // + 1
        weatherService.getCurrentWeather(coordinate: coordinate) { [weak self] result in
            dispatchGroup.leave() // - 1
            
            switch result {
            case let .success(response):
                currentWeather = response
                
            case let .failure(error):
                assertionFailure(error.localizedDescription)
                self?.view?.showAlert(error: error)
            }
        }
        
        dispatchGroup.enter() // + 1
        weatherService.getDetailHoursWeather(coordinate: coordinate) { [weak self] result in
            dispatchGroup.leave() // - 1
            
            switch result {
            case let .success(response):
                hoursWeather = response

            case let .failure(error):
                assertionFailure(error.localizedDescription)
                self?.view?.showAlert(error: error)
            }
        }
        
        
        dispatchGroup.notify(queue: .main) { [weak self] in
            // Method will call when dispatchGroup counter is equal == 0
            // Update Data Source
            
            guard let currentWeather = currentWeather,
                  let hoursWeather = hoursWeather else {
                      assertionFailure("Data is empty")
                      return
                  }
            
            self?.updateDataSource(currentWeather: currentWeather, hoursWeather: hoursWeather)
        }
    }
    
    func updateDataSource(
        currentWeather: WeatherResponse,
        hoursWeather: HoursResponse
    ) {
        view?.updateTitle(currentWeather.name)
        
        // подготовить dataSource для view
        var dataSource: [MainViewController.DataType] = []
        
        // Наполнить dataSource
        dataSource.append(.header(viewModel: buildHeaderMainCellViewModel(weatherResponse: currentWeather)))
        dataSource.append(.detail24Hours(viewModel: buildMain24HoursViewModel(hoursWeather: hoursWeather)))
        
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
    
    func buildMain24HoursViewModel(hoursWeather: HoursResponse) -> Main24HoursViewModel {
        let hoursList = hoursWeather.list
        
        let hoursViewModels = hoursList.map { item -> HourDetailWeatherCellViewModel in
            let time = item.dt.string(format: "HH:mm")
            let icon = item.weather.first?.icon ?? .clearDay

            return HourDetailWeatherCellViewModel(
                time: time,
                skyConditionType: .from(weatherIcon: icon),
                temp: item.main.temp
            )
        }

        return Main24HoursViewModel(dataSource: hoursViewModels) {
            print("Detail Button Tapped")
        }
    }
}
