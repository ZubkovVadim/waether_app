//
//  WeatherAPI.swift
//  WeatherApp
//
//  Created by Sergey Balashov on 07.02.2022.
//

import CoreLocation
import Moya

enum WeatherAPI: TargetType {
    case getWeather(requestModel: BaseWeatherRequest)

    var baseURL: URL {
        URL(string: "https://api.openweathermap.org/data/2.5/")!
    }

    var path: String {
        switch self {
        case .getWeather:
            return "onecall"
        }
    }

    var task: Task {
        switch self {
        case let .getWeather(requestModel):
            return .requestParameters(encodable: requestModel)
        }
    }
}
