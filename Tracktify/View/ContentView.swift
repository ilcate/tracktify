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
                               
                                    Image(systemName: "music.note")
                            }
                            .tag(Tab.home)
                            .background(Color.cBlack)
                        
                        TopView()
                            .tabItem {
                                
                                    Image(systemName: "magnifyingglass")
                                    
                            }
                            .tag(Tab.other1)
                            .background(Color.cBlack)
                        
                        SuggestView()
                            .tabItem {
                               
                                    Image(systemName: "wand.and.stars.inverse")
                            }
                            .tag(Tab.other2)
                            .background(Color.cBlack)
                        
                        
                    }
                    
                    
                    
                    
                }
            }.environmentObject(spotifyDataManager)
                .environmentObject(audioPlayer)
        } else {
            VStack{
                Spacer()
                Image("SuggestionIllustration")
                    .resizable()
                    .scaledToFit()
                Spacer()
                Text("Welcome to Tracktify")
                    .normalTextStyle(fontName: "LeagueSpartan-ExtraBold", fontSize: 32, fontColor: .white)
                    .padding(.bottom, 16)
                Text("The best app to easily track \n your Spotify stats")
                    .normalTextStyle(fontName: "LeagueSpartan-SemiBold", fontSize: 24, fontColor: .white)
                    .padding(.bottom, 16)
                    .multilineTextAlignment(.center)
                Text("Login with Spotify")
                    .normalTextStyle(fontName: "LeagueSpartan-SemiBold", fontSize: 20, fontColor: .cBlack)
                    .onTapGesture {
                        spotifyDataManager.showWebView.toggle()
                    }
                    .padding(12)
                    .background(.accent)
                    .clipShape(RoundedRectangle(cornerRadius: 12))
                    .sheet(isPresented: $spotifyDataManager.showWebView) {
                        if let urlRequest = APIService.shared.getAccessTokenURL() {
                            WebView(urlRequest: urlRequest) { token in
                                spotifyDataManager.accessToken = token
                                spotifyDataManager.showWebView = false
                                
                            }
                        }
                    }
                Spacer()
            }.frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(.cBlack)
            
           
        }
        
    }
    
    
}
