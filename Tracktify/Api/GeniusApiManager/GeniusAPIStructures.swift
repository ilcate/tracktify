
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

struct ResponseOfGen: Decodable{
    let song: GeniusSong
}

struct SearchDetailSong: Decodable{
    let response: ResponseOfGen
}


struct GeniusSong: Decodable {
    var title: String
    var artist_names: String
    
    
    var producer_artists : [Person]?
    var song_relationships: [SongRelationship]?
    var writer_artists: [Person]?
    var featured_artists: [Person]?
    
    var path: String
}
 

struct Person: Decodable, Hashable {
    var image_url: String?
    var name: String?
}

struct SongRelationship: Decodable {
    var relationship_type : String?
    var songs: [SmallSongInfo]?
}

struct SmallSongInfo: Decodable {
    var artist_names: String?
    var title: String?
}
