
import Foundation
import Alamofire

class GeniusApiManager: ObservableObject{
    private let headers = HTTPHeaders(["Authorization": "Bearer Xc2KaTMA5d24LopQ4aC2DXRnqSgGLbrppnbLcjLLS-Uidik0JLqls73a0NhFPHja"])
    var selectedSong : ResultSearch = ResultSearch(id: 0, path: "")
    
    func searchSong(artistName: String, songName: String){
        AF.request("https://api.genius.com/search?q=\(artistName.replacingOccurrences(of: " ", with: "%20").lowercased())%20\(songName.replacingOccurrences(of: " ", with: "%20").lowercased())", method: .get, headers: headers)
            .validate(statusCode: 200..<300)
            .responseDecodable(of: GeniusResearch.self){res in
                switch res.result {
                case .success(let results):
                    self.selectedSong = results.response.hits[0].result
                    self.searchInfoSong(songID: self.selectedSong.id)
                case .failure(let error):
                    print(error)
                }
            }
    }
    
    private func searchInfoSong(songID: Int){
        AF.request("https://api.genius.com/songs/\(songID)", method: .get, headers: headers)
            .validate(statusCode: 200..<300)
            .responseString{ song in
                print("!!!!!!!!!!!!!")
                print(song)
            }
    }
    
    

}

