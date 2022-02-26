//
//  HoursWeatherRequest.swift
//  WeatherApp
//
//  Created by Sergey Balashov on 23.02.2022.
//

import CoreLocation

class HoursWeatherRequest: BaseWeatherRequest {
    let count: Int

    init(count: Int, coordinate: CLLocationCoordinate2D) {
        self.count = count

        super.init(coordinate: coordinate)
    }

    private enum CodingKeys: String, CodingKey {
        case cnt
    }

    override func encode(to encoder: Encoder) throws {
        try super.encode(to: encoder)

        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(count, forKey: .cnt)
    }
}
