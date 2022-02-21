//
//  WeatherAPI.swift
//  WeatherApp
//
//  Created by Sergey Balashov on 07.02.2022.
//

import CoreLocation
import Moya

enum WeatherUnits: String {
    case standard, metric, imperial
}

enum WeatherAPI: TargetType {
    case getCurrent(coordinate: CLLocationCoordinate2D, units: WeatherUnits = .metric)

    var baseURL: URL {
        URL(string: "https://api.openweathermap.org/data/2.5/")!
    }

    var path: String {
        switch self {
        case .getCurrent:
            return "weather"
        }
    }

    var task: Task {
        switch self {
        case let .getCurrent(coordinate, units):
            return .requestParameters(
                parameters: [
                    "lat": coordinate.latitude,
                    "lon": coordinate.longitude,
                    "appid": Constants.Keys.weather,
                    "units": units.rawValue,
                    "lang": "ru"
                ],
                encoding: URLEncoding.default
            )
        }
    }
}
