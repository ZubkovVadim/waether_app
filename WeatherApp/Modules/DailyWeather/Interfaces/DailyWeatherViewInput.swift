//
//  DailyWeatherViewInput.swift
//  WeatherApp
//
//  Created by Sergey Balashov on 14.03.2022.
//

import Foundation

protocol DailyWeatherViewInput: AnyObject {
    func updateDataSource(dataSource: [DailyWeatherViewContoller.DataType])
}
