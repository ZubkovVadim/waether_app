//
//  WeatherAPI.swift
//  WeatherApp
//
//  Created by Sergey Balashov on 07.02.2022.
//

import Moya
import CoreLocation

enum WeatherAPI: TargetType {
    case getCurrent(coordinate: CLLocationCoordinate2D)
    
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
        case let .getCurrent(coordinate):
            return .requestParameters(
                parameters: [
                    "lat": coordinate.latitude,
                    "lon": coordinate.longitude,
                    "appid": Constants.Keys.weather
                ],
                encoding: URLEncoding.default
            )
        }
    }
}
