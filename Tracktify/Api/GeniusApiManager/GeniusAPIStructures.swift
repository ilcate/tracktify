
import Foundation

struct GeniusResearch: Decodable {
    var response: ResponseSearch
}

struct ResponseSearch: Decodable {
    var hits: [SingleHit]
}

struct SingleHit: Decodable {
    var result : ResultSearch
}

struct ResultSearch: Decodable {
    var id : Int
    var path : String
}
