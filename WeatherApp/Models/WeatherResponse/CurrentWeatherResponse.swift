//
//  CurrentWeatherResponse.swift
//  WeatherApp
//
//  Created by Sergey Balashov on 25.02.2022.
//

import Foundation

class CurrentWeatherResponse: BaseWeatherResponse {
    let sunrise: Date
    let sunset: Date
    let temp: Double

    private enum CodingKeys: String, CodingKey {
        case temp
        case sunrise
        case sunset
    }

    required init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        temp = try values.decode(Double.self, forKey: .temp)
        sunrise = try values.decode(Date.self, forKey: .sunrise)
        sunset = try values.decode(Date.self, forKey: .sunset)

        try super.init(from: decoder)
    }
}
