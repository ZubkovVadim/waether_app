//
//  HourlyWeatherResponse.swift
//  WeatherApp
//
//  Created by Sergey Balashov on 25.02.2022.
//

import Foundation

class HourlyWeatherResponse: BaseWeatherResponse {
    let temp: Double
    let feelTemp: Double

    /// Probability of precipitation
    let pop: Double

    private enum CodingKeys: String, CodingKey {
        case temp, pop
        case feelTemp = "feels_like"
    }

    required init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        temp = try values.decode(Double.self, forKey: .temp)
        pop = try values.decode(Double.self, forKey: .pop)
        feelTemp = try values.decode(Double.self, forKey: .feelTemp)

        try super.init(from: decoder)
    }
}
