

import Foundation

struct Weather: Decodable {
    let id: Int?
    let main: String?
    let description: String?
    let icon: IconType

    enum CodingKeys: String, CodingKey {
        case id
        case main
        case description
        case icon
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decodeIfPresent(Int.self, forKey: .id)
        main = try values.decodeIfPresent(String.self, forKey: .main)
        description = try values.decodeIfPresent(String.self, forKey: .description)
        icon = try values.decodeIfPresent(IconType.self, forKey: .icon) ?? .clearDay
    }
}

extension Weather {
    enum IconType: String, Decodable {
        case clearDay = "01d"
        case clearNight = "01n"
        
        case fewCloudsDay = "02d"
        case fewCloudsNight = "02n"
        
        case cloudsDay = "03d"
        case cloudsNight = "03n"
        
        case brokenCloudsDay = "04d"
        case brokenCloudsNight = "04n"
        
        case snowerRainDay = "09d"
        case snowerRainNight = "09n"
        
        case rainDay = "10d"
        case rainNight = "10n"
        
        case thunderstormDay = "11d"
        case thunderstormNight = "11n"
        
        case snowDay = "13d"
        case snowNight = "13n"
        
        case mistDay = "50d"
        case mistNight = "50n"
    }
}
