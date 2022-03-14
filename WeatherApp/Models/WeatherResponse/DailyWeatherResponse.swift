//
//  DailyWeatherResponse.swift
//  WeatherApp
//
//  Created by Sergey Balashov on 25.02.2022.
//

import Foundation

class DailyWeatherResponse: BaseWeatherResponse {
    let temp: DailyTemp
    let feelsLike: DailyTemp
    /// Probability of precipitation
    let pop: Double

    private enum CodingKeys: String, CodingKey {
        case temp
        case feelsLike = "feels_like"
        case pop
    }

    required init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        temp = try values.decode(DailyTemp.self, forKey: .temp)
        feelsLike = try values.decode(DailyTemp.self, forKey: .feelsLike)
        pop = try values.decode(Double.self, forKey: .pop)

        try super.init(from: decoder)
    }
}

extension DailyWeatherResponse {
    struct DailyTemp: Decodable {
        let day: Double
        let min: Double?
        let max: Double?
        let night: Double
        let eve: Double?
        let morn: Double?
    }
}
