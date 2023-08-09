import Foundation

struct Flights: Codable {
    let flights: [Flight]
}


struct Flight: Codable {
    let startDate, endDate, startLocationCode, endLocationCode: String
    let startCity, endCity, serviceClass: String
    let seats: [Seat]
    let price: Int
    let searchToken: String
    var isLiked: Bool?
}

struct Seat: Codable {
    let passengerType: String
    let count: Int
}
