
import Foundation

struct TopTrack: Decodable {
    var items: [Song]
}

struct Song : Decodable, Hashable, Equatable {
    var id: String
    var name: String
    var uri: String
    var preview_url: String
    var explicit: Bool
    var artists: [Artist]
    var album: Album
    var duration_ms: Float
}

struct Artist: Decodable, Hashable {
    var id: String
    var name: String
}

struct Album: Decodable, Hashable {
    var id: String
    var name: String
    var total_tracks: Int
    var images: [Cover]
}

struct Cover: Decodable, Hashable {
    var url: String
}

