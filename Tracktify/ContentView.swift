import SwiftUI

struct ContentView: View {
    @StateObject var spotifyManager = SpotifyApiManager()
    
    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundStyle(.tint)
            Text("Get token from spotify!")
//                .onTapGesture {
//                    spotifyManager.getSpotifyToken()
//                }
                .padding(.bottom, 20)
            Text("TryToLog")
                .onTapGesture {
                    let queryItems = [URLQueryItem(name: "client_id", value: spotifyManager.clientId), URLQueryItem(name: "response_type", value: "code"), URLQueryItem(name: "redirect_uri", value: "spotify-ios-quick-start://spotify-login-callback")]
                    var urlComps = URLComponents(string: "https://accounts.spotify.com/authorize?")!
                    urlComps.queryItems = queryItems
                    let result = urlComps.url!
                    print(result)
                    UIApplication.shared.open(result)
                }
        }
        .padding()
    }
}
