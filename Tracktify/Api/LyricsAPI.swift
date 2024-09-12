//
//  LyricsAPI.swift
//  Tracktify
//
//  Created by Christian Catenacci on 12/09/24.
//

import Foundation
import Alamofire

class LyricsManager: ObservableObject {
    @Published var songLyrics = ""
    
    func getSongLyrics(ArtistName: String, SongName: String) {
        let encodedArtistName = ArtistName.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed) ?? ArtistName
        let encodedSongName = SongName.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed) ?? SongName
        
        AF.request("https://api.lyrics.ovh/v1/\(encodedArtistName)/\(encodedSongName)", method: .get)
            .validate(statusCode: 200..<300)
            .responseDecodable(of: Lyrics.self) { resp in
                switch resp.result {
                case .success(let results):
                    self.songLyrics = results.lyrics
                case .failure(let error):
                    print(error)
                }
            }
    }
}
