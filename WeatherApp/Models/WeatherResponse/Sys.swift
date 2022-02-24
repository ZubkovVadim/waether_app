

import Foundation

struct Sys: Decodable {
    let type: Int?
    let id: Int?
    let message: Double?
    let country: String?
    let sunrise: Date
    let sunset: Date
    
    let pod: PartDayType?
}

extension Sys {
    enum PartDayType: String, Decodable {
        case night = "n"
        case day = "d"
    }
}
