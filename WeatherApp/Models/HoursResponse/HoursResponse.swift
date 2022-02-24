//

import Foundation

struct HoursResponse : Decodable {
	let cod : String?
	let message : Double?
	let cnt : Int?
	let list : [WeatherResponse]
	let city : City?
}
