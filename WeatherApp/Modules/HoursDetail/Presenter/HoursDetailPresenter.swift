//
//  HoursDetailPresenter.swift
//  WeatherApp
//
//  Created by Sergey Balashov on 28.02.2022.
//

import Foundation

class HoursDetailPresenter {
    weak var view: HoursDetailViewInput?
    
    private let hourlyWeather: [HourlyWeatherResponse]
    
    init(hourlyWeather: [HourlyWeatherResponse]) {
        self.hourlyWeather = hourlyWeather
    }
}

extension HoursDetailPresenter: HoursDetailViewOutput {
    func viewDidLoad() {
        updateView()
    }
}

private extension HoursDetailPresenter {
    func updateView() {
        let viewModels = hourlyWeather.map { weather -> HoursDetailWeatherCellViewModel in
            HoursDetailWeatherCellViewModel(date: weather.dt.string(format: "EEEEEE dd/MM"),
                                            time: weather.dt.string(format: "HH:mm"),
                                            temp: weather.temp,
                                            condition: .from(weatherIcon: weather.weather?.icon ?? .clearDay),
                                            description: weather.weather?.description,
                                            feelTemp: weather.feelTemp,
                                            wind: weather.windSpeed,
                                            clouds: weather.clouds,
                                            rain: weather.pop)
        }
        .map { HoursDetailViewController.DataType.row(viewModel: $0) }
        
        view?.updateDataSource(dataSource: viewModels)
    }
}
