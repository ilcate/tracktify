

import Foundation
import Alamofire

class SpotifyDataManager: ObservableObject {
    @Published var accessToken: String? = UserDefaults.standard.string(forKey: "Authorization")
    @Published var showWebView = false
    @Published var yourTopTracks : [Song] = []
    private var term = ["short_term", "medium_term", "long_term"]
    @Published var termOfTopTrack = 0
    
    
    
    func logout(){
        UserDefaults.standard.removeObject(forKey: "Authorization")
        self.accessToken = nil
    }
    
    
    func getMySpotifyTopTraks(){
         let headers = HTTPHeaders(["Authorization": "Bearer \(self.accessToken!)"])
         AF.request("https://api.spotify.com/v1/me/top/tracks?time_range=\(term[termOfTopTrack])&limit=5", method: .get, headers: headers)
             .validate(statusCode: 200..<300)
             .responseDecodable(of: TopTrack.self){ res in
                 switch res.result {
                 case .success(let topTracks):
                     self.yourTopTracks = topTracks.items
                 case .failure(let error):
                     print(error)
                 }
             }
     }
  
}
