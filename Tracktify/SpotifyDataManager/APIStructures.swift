
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


struct SuggestSong: Decodable, Hashable {
    var tracks: [Song]
}

struct Song : Decodable, Hashable, Equatable {
    var id: String
    var name: String
    var uri: String
    var preview_url: String?
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
    var id: String
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


struct Genres: Decodable{
    var genres: [String]
}


struct PlaylistCreated : Codable {
    var id: String
}















struct CreationPlaylist: Encodable {
    var name: String
    var description: String
    var `public`: Bool
}

struct PlaylistInfo: Encodable {
    var uris: [String]
    var position : Int
}



struct SpotifyPlaylistsResponse: Decodable {
    var message: String
    var playlists: Playlists
}

struct Playlists: Decodable {
    var href: String
    var items: [PlaylistItem]
    var limit: Int
    var next: String?
    var offset: Int
    var previous: String?
    var total: Int
}

struct PlaylistItem: Decodable, Hashable {
    var collaborative: Bool
    var description: String
    var external_urls: ExternalUrls
    var href: String
    var id: String
    var images: [ImageFetch]
    var name: String
    var owner: PlaylistOwner
    var primary_color: String?
    var `public`: Bool
    var snapshot_id: String
    var tracks: TracksInfo
    var type: String
    var uri: String
}

struct ExternalUrls: Decodable, Hashable {
    var spotify: String
}

struct PlaylistOwner: Decodable, Hashable {
    var display_name: String
    var external_urls: ExternalUrls
    var href: String
    var id: String
    var type: String
    var uri: String
}

struct TracksInfo: Decodable, Hashable {
    var href: String
    var total: Int
}
