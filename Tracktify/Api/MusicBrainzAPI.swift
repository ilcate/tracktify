//
//  MusicBrainzAPI.swift
//  Tracktify
//
//  Created by Christian Catenacci on 12/09/24.
//

import Foundation
import Alamofire


class MusicBrainzManager : ObservableObject {
    
    
    func getSongInfo(songName : String, artistName: String){
        AF.request("https://musicbrainz.org/ws/2/recording/?query=recording:\(songName) AND artist:\(artistName)&fmt=json", method: .get)
            .validate(statusCode: 200..<300)
            .responseDecodable(of: MBResponse.self){res in
                switch res.result {
                case .success(let trackID):
                    if trackID.recordings.count > 0 {
                        print(trackID.recordings[0])
                        self.getSongCredit(songID: trackID.recordings[0].id)
                    }
                case .failure(let error):
                    print(error)
                }
            }
    }
    
    func getSongCredit(songID : String ){
        AF.request("https://musicbrainz.org/ws/2/release/59211ea4-ffd2-4ad9-9a4e-941d3148024a?inc=artist-credits+labels+discids+recordings", method: .get)
            .validate(statusCode: 200..<300)
            .responseString { res in
                print(res)
            }
    }
    
}
