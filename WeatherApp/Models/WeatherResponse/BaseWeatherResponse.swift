//
//  BaseWeatherResponse.swift
//  WeatherApp
//
//  Created by Sergey Balashov on 25.02.2022.
//

import Foundation

class BaseWeatherResponse: Decodable {
    let dt: Date
    let weather: Weather?

    let humidity: Int
    let pressure: Double
    let clouds: Double
    let windSpeed: Double
    let uvi: Double

    // Unused now
    let dew_point: Double?
    let visibility: Int?
    let windDeg: Int?

    private enum CodingKeys: String, CodingKey {
        case dt
        case temp
        case pressure
        case humidity
        case dew_point
        case uvi
        case clouds
        case visibility
        case wind_speed
        case wind_deg
        case weather
    }

    required init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        dt = try values.decode(Date.self, forKey: .dt)

        pressure = try values.decode(Double.self, forKey: .pressure)
        humidity = try values.decode(Int.self, forKey: .humidity)
        uvi = try values.decode(Double.self, forKey: .uvi)
        clouds = try values.decode(Double.self, forKey: .clouds)
        windSpeed = try values.decode(Double.self, forKey: .wind_speed)

        let weatherArray = try values.decodeIfPresent([Weather].self, forKey: .weather)
        weather = weatherArray?.first

        visibility = try values.decodeIfPresent(Int.self, forKey: .visibility)
        dew_point = try values.decodeIfPresent(Double.self, forKey: .dew_point)
        
        windDeg = try values.decodeIfPresent(Int.self, forKey: .wind_deg)
    }
}
