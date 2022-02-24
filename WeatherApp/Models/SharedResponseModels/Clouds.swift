

import Foundation

struct Clouds: Codable {
    let all: Int

    enum CodingKeys: String, CodingKey {
        case all
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        all = try values.decode(Int.self, forKey: .all)
    }
}
