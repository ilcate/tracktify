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
    
    func getSongLyrics(artistName: String, songName: String) {
        let encodedArtistName = artistName.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed) ?? artistName
        let encodedSongName = songName.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed) ?? songName
        
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
