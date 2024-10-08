

import Foundation
import Alamofire

class SpotifyDataManager: ObservableObject {
    @Published var accessToken: String? = UserDefaults.standard.string(forKey: "Authorization")
    @Published var showWebView = false
    @Published var yourTopTracks : [Song] = []
    @Published var newReleasedAlbums : [AlbumRel] = []
    @Published var recentlyPlayedSongs : [RecentItems] = []
    @Published var spotifyGenres : [String] = []
    private var term = ["short_term", "medium_term", "long_term"]
    @Published var termOfTopTrack = 0
    @Published var username = ""
    @Published var profilePicture = ""
    
    @Published var selectedGenres : [String] = []
    @Published var quantitySong = 30
    @Published var minDancebility = 0.1
    @Published var minEnergy = 0.1
    @Published var minPopularity = 0
    @Published var maxPopularity = 100
    
    @Published var suggestions : [Song] = []
    
    
    @Published var songQuantity: Int = 1
    @Published var energy = 50.0
    @Published var danceOnPlaylist = true
    @Published var isEditing = false
    @Published var selection = "No thx"
    @Published var possibilities = ["Yes please", "So and so", "No thx"]
    @Published var uris : [String] = []
    @Published var playlistName = "New Playlist"
    
    @Published var playlistInItaly : [PlaylistItem] = []
    
    private var userId = ""
    
    
    
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
                    self.logout()
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
                    self.userId = info.id
                    self.profilePicture = info.images[info.images.count-1].url
                case .failure(let error):
                    self.logout()
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
                    self.logout()
                }
            }
    }
    
    func getRecentlyPlayed(number : Int){
        let headers = HTTPHeaders(["Authorization": "Bearer \(self.accessToken!)"])
        AF.request("https://api.spotify.com/v1/me/player/recently-played?limit=\(number)", method: .get, headers: headers)
            .validate(statusCode: 200..<300)
            .responseDecodable(of: RecentTrack.self){ res in
                switch res.result {
                case .success(let recentlyPlayed):
                    self.recentlyPlayedSongs = recentlyPlayed.items
                    if self.recentlyPlayedSongs.count > 3 {
                        self.recentlyPlayedSongs = Array(self.recentlyPlayedSongs.prefix(3))
                    }
                    
                case .failure(let error):
                    print(error)
                }
            }
    }
    
    func getMusicGenres(){
        let headers = HTTPHeaders(["Authorization": "Bearer \(self.accessToken!)"])
        AF.request("https://api.spotify.com/v1/recommendations/available-genre-seeds", method: .get, headers: headers)
            .validate(statusCode: 200..<300)
            .responseDecodable(of: Genres.self){ resp in
                switch resp.result {
                case .success(let allGenres):
                    self.spotifyGenres = allGenres.genres
                case .failure(let error):
                    print(error)
                }
            }
    }
    
    func getSuggestions(){
        let headers = HTTPHeaders(["Authorization": "Bearer \(self.accessToken!)"])
        let url = "https://api.spotify.com/v1/recommendations?limit=\(songQuantity)&seed_genres=\(selectedGenres.joined(separator: "%2C"))&min_danceability=\(danceOnPlaylist ? 0.7 : 0)&min_energy=\(energy / 100 )&min_popularity=\(selection == "No thx" ? 0 : selection == "So and so" ?  30 : 60)&max_popularity=\(selection == "No thx" ? 30: selection == "So and so" ?  60 : 90)"
        
        print(url)
        AF.request(url, method: .get, headers: headers)
            .validate(statusCode: 200..<300)
            .responseDecodable(of: SuggestSong.self){ res in
                switch res.result {
                case .success(let results):
                    self.suggestions = results.tracks
                    self.uris = self.extractURIs(from: results.tracks)
                case .failure(let error):
                    print(error)
                }
            }
    }
    
    func createPlaylist(){
        let headers = HTTPHeaders(["Authorization": "Bearer \(self.accessToken!)"])
        let toSend = CreationPlaylist(name: self.playlistName, description: "This is a playlist made with Tracktify", public: false)
        var playlistId = ""
        
        AF.request("https://api.spotify.com/v1/users/\(userId)/playlists", method: .post, parameters: toSend, encoder: JSONParameterEncoder.default, headers: headers)
            .validate(statusCode: 200..<300)
            .responseDecodable(of: PlaylistCreated.self){ resp in
                switch resp.result {
                case .success(let results):
                    playlistId = results.id
                   
                    self.addSongToPlaylist(id: playlistId)
                    
                case .failure(let error):
                    print(error)
                }
            }
        
    
    }
    
    func addSongToPlaylist(id: String){
        let headers = HTTPHeaders(["Authorization": "Bearer \(self.accessToken!)"])
        let toSend = PlaylistInfo(uris: self.uris, position: 0)
        
        AF.request("https://api.spotify.com/v1/playlists/\(id)/tracks", method: .post, parameters: toSend, encoder: JSONParameterEncoder.default, headers: headers)
            .validate(statusCode: 200..<300)
            .responseString{ resp in
                print(resp)
            }
    }
    
    
    func mostStreamedPlaylist(){
        let headers = HTTPHeaders(["Authorization": "Bearer \(self.accessToken!)"])
        
        AF.request("https://api.spotify.com/v1/browse/featured-playlists?locale=it_IT&limit=4&offset=0", method: .get, headers: headers)
            .validate(statusCode: 200..<300)
            .responseDecodable(of: SpotifyPlaylistsResponse.self){ resp in
                switch resp.result {
                case .success(let results):
                    self.playlistInItaly = results.playlists.items
                    
                case .failure(let error):
                    print(error)
                }
                
            }
    }
    

   
    
    
    func extractURIs(from tracks: [Song]) -> [String] {
        return tracks.compactMap { $0.uri }
    }
    
    
    func getSomeRecentlyPlayed(){
        self.getRecentlyPlayed(number: 3)
    }
    
    func getALotRecentlyPlayed(){
        self.getRecentlyPlayed(number: 50)
    }
    
}


