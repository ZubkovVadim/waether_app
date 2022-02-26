//
//  SkyConditionType.swift
//  WeatherApp
//
//  Created by Sergey Balashov on 25.02.2022.
//

import Foundation

enum SkyConditionType {
    case clear, clouds, rain
    
    static func from(weatherIcon: Weather.IconType) -> SkyConditionType {
        switch weatherIcon {
        case .clearDay, .clearNight:
            return .clear
            
        case .fewCloudsDay, .fewCloudsNight,
                .cloudsDay, .cloudsNight,
                .brokenCloudsDay,.brokenCloudsNight,
                .mistDay, .mistNight:
            
            return .clouds
            
        case .snowerRainDay, .snowerRainNight,
                .rainDay, .rainNight,
                .thunderstormDay, .thunderstormNight,
                .snowDay, .snowNight:
            
            return .rain
        }
    }
    
    var iconName: String {
        switch self {
        case .clear:
            return "sun_icon"
        case .clouds:
            return "color_clouds_icon"
        case .rain:
            return "rain_icon"
        }
    }
}
