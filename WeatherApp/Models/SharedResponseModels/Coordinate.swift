
import Foundation

struct Coordinate: Codable {
    let lon: Double?
    let lat: Double?

    enum CodingKeys: String, CodingKey {
        case lon
        case lat
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        lon = try values.decodeIfPresent(Double.self, forKey: .lon)
        lat = try values.decodeIfPresent(Double.self, forKey: .lat)
    }
}
