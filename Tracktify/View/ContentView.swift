import SwiftUI
import Alamofire

enum Tab {
    case home
    case other1
    case other2
    case profile
}

struct ContentView: View {
    @StateObject var spotifyDataManager = SpotifyDataManager()
    @StateObject var audioPlayer = AudioPlayer()
    @State private var selection: Tab = .home
    
    var body: some View {
        if (spotifyDataManager.accessToken != nil) {
            NavigationStack{
                VStack {
                    TabView(selection: $selection) {
                        HomeView()
                            .tabItem {
                                VStack {
                                    Image(systemName: "house")
                                    Text("home")
                                }
                            }
                            .tag(Tab.home)
                            .background(Color.cBlack)
                        
                        TopView()
                            .tabItem {
                                VStack {
                                    Image(systemName: "playstation.logo")
                                    Text("top")
                                }
                            }
                            .tag(Tab.other1)
                        
                        SuggestView()
                            .tabItem {
                                VStack {
                                    Image(systemName: "xbox.logo")
                                    Text("suggest")
                                }
                            }
                            .tag(Tab.other2)
                            .background(Color.cBlack)
                        
                        OtherView()
                            .tabItem {
                                VStack {
                                    Image(systemName: "person")
                                    Text("profile")
                                }
                            }
                            .tag(Tab.profile)
                    }
                    
                    
                    
                    
                }
            }.environmentObject(spotifyDataManager)
                .environmentObject(audioPlayer)
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
