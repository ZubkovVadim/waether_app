//
//  DailyWeatherPresenter.swift
//  WeatherApp
//
//  Created by Sergey Balashov on 14.03.2022.
//

import Foundation

class DailyWeatherPresenter {
    weak var view: DailyWeatherViewInput?
    
    private let dailyWeathers: [DailyWeatherResponse]
    
    private var selectedIndex: Int = 0 {
        didSet {
            updateDataSource()
        }
    }
    
    init(dailyWeathers: [DailyWeatherResponse]) {
        self.dailyWeathers = dailyWeathers
    }
}

extension DailyWeatherPresenter: DailyWeatherViewOutput {
    func viewDidLoad() {
        updateDataSource()
    }
}

private extension DailyWeatherPresenter {
    func updateDataSource() {
        let weather = dailyWeathers[selectedIndex]
        
        let dayInformation = buildDayWeatherInformationViewModel(weather: weather, isDay: true)
        let nightInformation = buildDayWeatherInformationViewModel(weather: weather, isDay: false)

        view?.updateDataSource(dataSource: [
            .daySelection(viewModel: buildDaySelectionViewModel()),
            .weatherInformation(viewModel: dayInformation),
            .weatherInformation(viewModel: nightInformation)
        ])
    }
    
    func buildDaySelectionViewModel() -> DailySelectionTableCellViewModel {
        let days = dailyWeathers.map { weather -> DayTitleCollectionCellViewModel in
            let date = weather.dt.string(format: "dd/MM EEEEEE")
            
            return DayTitleCollectionCellViewModel(date: date)
        }
        
        return DailySelectionTableCellViewModel(dataSource: days, index: selectedIndex) { [weak self] cellIndex in
            print("index did tap", cellIndex)
            self?.selectedIndex = cellIndex
        }
    }
    
    func buildDayWeatherInformationViewModel(
        weather: DailyWeatherResponse,
        isDay: Bool
    ) -> WeatherInformationTableCellViewModel {
        WeatherInformationTableCellViewModel(
            timeOfDay: isDay ? "День" : "Ночь",
            skyConditionType: .from(weatherIcon: weather.weather?.icon ?? .clearDay),
            temp: isDay ? weather.temp.day : weather.temp.night,
            weatherDescription: weather.weather?.description ?? "",
            feelTemp: isDay ? weather.feelsLike.day : weather.feelsLike.night,
            uvIndex: weather.uvi,
            wind: weather.windSpeed,
            clouds: weather.clouds,
            rain: weather.pop
        )
    }
}
