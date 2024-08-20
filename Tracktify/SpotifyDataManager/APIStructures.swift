
import Foundation

struct TopTrack: Decodable {
    var items: [Song]
}

struct RecentTrack: Decodable {
    var items: [RecentItems]
}

struct RecentItems: Decodable, Hashable {
    var track: Song
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
    var images: [ImageFetch]
}


struct PersonalInfo: Decodable {
    var display_name: String
    var images: [ImageFetch]
}


struct ImageFetch: Decodable, Hashable {
    var url: String
}


struct NewReleases: Decodable {
    var albums: NewAlbumReleases
}

struct NewAlbumReleases: Decodable {
    var items: [AlbumRel]
    
}

struct AlbumRel: Decodable, Hashable {
    var artists: [Artist]
    var id : String
    var images: [ImageFetch]
    var name: String
    var release_date: String
}
