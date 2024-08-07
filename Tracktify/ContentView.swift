import SwiftUI
import Alamofire

struct ContentView: View {
    @StateObject var spotifyDataManager = SpotifyDataManager()
    @StateObject var audioPlayer = AudioPlayer()
    
    var body: some View {
        NavigationStack{
            VStack {
                if spotifyDataManager.accessToken != nil {
                    VStack{
                        AppView()
                        Spacer()
                        Text("logout")
                            .foregroundStyle(.white)
                            .padding(.vertical, 8)
                            .padding(.horizontal, 12)
                            .background(.red)
                            .clipShape(RoundedRectangle(cornerRadius: 14))
                            .onTapGesture {
                                spotifyDataManager.logout()
                            }
                    }
                
                    
                } else {
                    Text("Login to Spotify")
                        .onTapGesture {
                            spotifyDataManager.showWebView.toggle()
                        }
                    .sheet(isPresented: $spotifyDataManager.showWebView) {
                        if let urlRequest = APIService.shared.getAccessTokenURL() {
                            WebView(urlRequest: urlRequest) { token in
                                spotifyDataManager.accessToken = token
                                spotifyDataManager.showWebView = false
                                
                            }
                        }
                    }
                }
                
                
            }
        }
        .environmentObject(spotifyDataManager)
        .environmentObject(audioPlayer)
    }

  
}
