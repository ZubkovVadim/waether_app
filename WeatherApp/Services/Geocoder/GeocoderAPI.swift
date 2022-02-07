//
//  GeocoderAPI.swift
//  WeatherApp
//
//  Created by Sergey Balashov on 07.02.2022.
//

import CoreLocation
import Moya

enum GeocoderAPI: TargetType {
    case getLocation(coordinate: CLLocationCoordinate2D)

    var baseURL: URL {
        URL(string: "https://geocode-maps.yandex.ru/1.x")!
    }

    var path: String { "" }
    
    var task: Task {
        switch self {
        case let .getLocation(coordinate):
            let format = [coordinate.longitude, coordinate.latitude]
                .map { String(describing: $0) }
                .joined(separator: ",")
            
            return Task.requestParameters(
                parameters: [
                    "format": "json",
                    "apikey": Constants.Keys.geocoder,
                    "geocode": format
                ],
                encoding: URLEncoding.default
            )
        }
    }
}
