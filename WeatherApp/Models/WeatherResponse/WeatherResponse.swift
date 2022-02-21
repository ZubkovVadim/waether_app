//
//  WeatherResponse.swift
//  WeatherApp
//
//  Created by Sergey Balashov on 07.02.2022.
//

import Foundation

struct WeatherResponse: Decodable {
    let coord: Coordinate?
    var weather: [Weather] = []
    let base: String?
    let main: Main
    let visibility: Int?
    let wind: Wind?
    let clouds: Clouds
    let dt: Date?
    let sys: Sys
    let timezone: Int?
    let id: Int?
    let name: String?
    let cod: Int?
}
