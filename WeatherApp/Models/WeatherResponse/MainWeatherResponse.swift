//
//  MainWeatherResponse.swift
//  WeatherApp
//
//  Created by Sergey Balashov on 07.02.2022.
//

import Foundation

struct MainWeatherResponse: Decodable {
    let lat: Double?
    let lon: Double?
    let timezone: String?
    let timezone_offset: Int?

    let current: CurrentWeatherResponse?
    let hourly: [HourlyWeatherResponse]
    let daily: [DailyWeatherResponse]
}
