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
    
    func didRequestRefresh() {
        loadWeather()
    }
}

private extension MainViewPresenter {
    func loadWeather() {
        guard let coordinate = realmStorage.getLocation() else {
            return
        }
        
        weatherService.getWeather(coordinate: coordinate) { [weak self] result in
            switch result {
            case let .success(weather):
                self?.updateDataSource(weather: weather)
                
            case let .failure(error):
                self?.view?.showAlert(error: error)
            }
        }
    }
    
    func updateDataSource(weather: MainWeatherResponse) {
        view?.updateTitle(weather.timezone)
        
        // подготовить dataSource для view
        var dataSource: [MainViewController.DataType] = []
        
        // Наполнить dataSource
        if let viewModel = buildHeaderMainCellViewModel(weather: weather) {
            dataSource.append(.header(viewModel: viewModel))
        }
        
        if let viewModel = buildMain24HoursViewModel(weather: weather) {
            dataSource.append(.detail24Hours(viewModel: viewModel))
        }
        
        dataSource.append(.headerDaily(viewModel: buildHeaderDailyLabelCellViewModel()))
        
        let dayViewModels = buildDailyWeatherCellViewModel(weather: weather)
        let dataSourceModels = dayViewModels.map { viewModel -> MainViewController.DataType in
            return .dayWeather(viewModel: viewModel)
        }
        
        dataSource.append(contentsOf: dataSourceModels)
        
        view?.updateWeather(dataSource: dataSource)
    }
    
    func buildHeaderMainCellViewModel(weather: MainWeatherResponse) -> HeaderMainCellViewModel? {
        guard let current = weather.current else {
            return nil
        }
        
        let todayValue = Date().string(format: "HH:mm', 'E dd MMMM")
        
        return HeaderMainCellViewModel(
            minDegrees: weather.daily.first?.temp.min,
            maxDegrees: weather.daily.first?.temp.max,
            currentDegrees: current.temp,
            weatherDescription: current.weather?.description,
            sunsetTime: current.sunset.string(format: "HH:mm"),
            sunriseTime: current.sunrise.string(format: "HH:mm"),
            cloudValue: current.clouds,
            windValue: current.windSpeed,
            humidityValue: current.humidity,
            todayValue: todayValue
        )
    }
    
    func buildMain24HoursViewModel(weather: MainWeatherResponse) -> Main24HoursViewModel? {
        guard !weather.hourly.isEmpty else {
            return nil
        }
        
        let hoursViewModels = weather.hourly.map { item -> HourDetailWeatherCellViewModel in
            let time = item.dt.string(format: "HH:mm")
            let icon = item.weather?.icon ?? .clearDay
            
            return HourDetailWeatherCellViewModel(
                time: time,
                skyConditionType: .from(weatherIcon: icon),
                temp: item.temp
            )
        }
        
        return Main24HoursViewModel(dataSource: hoursViewModels) {
            print("Detail Button Tapped")
        }
    }
    
    func buildHeaderDailyLabelCellViewModel() -> HeaderDailyLabelCellViewModel {
        HeaderDailyLabelCellViewModel {
            print("Daily Detail Button Tapped")
        }
    }
    
    func buildDailyWeatherCellViewModel(weather: MainWeatherResponse) -> [DayWeatherCellViewModel] {
        weather.daily[1 ..< weather.daily.count].map { weatherDay in
            let icon = weatherDay.weather?.icon ?? .clearDay
            
            return DayWeatherCellViewModel(
                date: weatherDay.dt.string(format: "dd/MM"),
                icon: .from(weatherIcon: icon),
                rainProbability: weatherDay.pop,
                description: weatherDay.weather?.description,
                minTemp: weatherDay.temp.min,
                maxTemp: weatherDay.temp.max
            )
        }
    }
}
