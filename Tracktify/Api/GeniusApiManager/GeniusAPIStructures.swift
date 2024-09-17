
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
    let title: String
    let artist_names: String
    
    let producer_artists : [Person]?
    let song_relationships: [SongRelationship]?
    let writer_artists: [Person]?
    let featured_artists: [Person]?
}
 

struct Person: Decodable {
    let image_url : String?
    let Name: String?
}

struct SongRelationship: Decodable {
    let relationship_type : String?
    let songs: [SmallSongInfo]?
}

struct SmallSongInfo: Decodable {
    let artist_names: String?
    let title: String?
}
