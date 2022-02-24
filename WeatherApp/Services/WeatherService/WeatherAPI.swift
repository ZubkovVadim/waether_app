//
//  WeatherAPI.swift
//  WeatherApp
//
//  Created by Sergey Balashov on 07.02.2022.
//

import CoreLocation
import Moya

enum WeatherAPI: TargetType {
    case getCurrent(requestModel: BaseWeatherRequest)
    case getHours(requestModel: HoursWeatherRequest)

    var baseURL: URL {
        URL(string: "https://api.openweathermap.org/data/2.5/")!
    }

    var path: String {
        switch self {
        case .getCurrent:
            return "weather"
        case .getHours:
            return "forecast/hourly"
        }
    }

    var task: Task {
        switch self {
        case let .getCurrent(requestModel):
            return .requestParameters(encodable: requestModel)
        case let .getHours(requestModel):
            return .requestParameters(encodable: requestModel)
        }
    }
}
