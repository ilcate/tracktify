

import Foundation
import Alamofire

class SpotifyDataManager: ObservableObject {
    @Published var accessToken: String? = UserDefaults.standard.string(forKey: "Authorization")
    @Published var showWebView = false
    @Published var yourTopTracks : [Song] = []
    @Published var newReleasedAlbums : [AlbumRel] = []
    private var term = ["short_term", "medium_term", "long_term"]
    @Published var termOfTopTrack = 0
    @Published var username = ""
    @Published var profilePicture = ""
    
    
    
    
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
    
    func getMySpotifyInformation(){
         let headers = HTTPHeaders(["Authorization": "Bearer \(self.accessToken!)"])
         AF.request("https://api.spotify.com/v1/me", method: .get, headers: headers)
             .validate(statusCode: 200..<300)
             .responseDecodable(of: PersonalInfo.self){ res in
                 switch res.result {
                 case .success(let info):
                     self.username = info.display_name
                     self.profilePicture = info.images[info.images.count-1].url
                 case .failure(let error):
                     print(error)
                 }
             }
     }
    
    func getAlbumNewReleases(){
         let headers = HTTPHeaders(["Authorization": "Bearer \(self.accessToken!)"])
         AF.request("https://api.spotify.com/v1/browse/new-releases?offset=0&limit=10", method: .get, headers: headers)
             .validate(statusCode: 200..<300)
             .responseDecodable(of: NewReleases.self){ res in
                 switch res.result {
                 case .success(let album):
                     self.newReleasedAlbums = album.albums.items
                 case .failure(let error):
                     print(error)
                 }
             }
     }
    
}
