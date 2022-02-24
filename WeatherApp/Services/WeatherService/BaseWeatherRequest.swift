//
//  BaseWeatherRequest.swift
//  WeatherApp
//
//  Created by Sergey Balashov on 23.02.2022.
//

import CoreLocation

class BaseWeatherRequest: Encodable {
    let coordinate: CLLocationCoordinate2D
    let units: WeatherUnits = .metric
    let appid: String = Constants.Keys.weather
    let mode: String = "json"
    let lang: String = "ru"
    
    init(coordinate: CLLocationCoordinate2D) {
        self.coordinate = coordinate
    }
    
    private enum CodingKeys: String, CodingKey {
        case lat, lon
        case appid
        case mode
        case lang
        case units
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        
        try container.encode(coordinate.latitude, forKey: .lat)
        try container.encode(coordinate.longitude, forKey: .lon)
        try container.encode(appid, forKey: .appid)
        try container.encode(mode, forKey: .mode)
        try container.encode(lang, forKey: .lang)
        try container.encode(units, forKey: .units)
    }
}

enum WeatherUnits: String, Encodable {
    case standard, metric, imperial
}

