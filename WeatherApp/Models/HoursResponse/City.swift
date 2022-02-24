
import Foundation

struct City : Codable {
	let id : Int?
	let name : String?
	let coord : Coordinate?
	let country : String?
	let timezone : Int?
    let sunrise: Date
    let sunset: Date
}
