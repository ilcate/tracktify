import SwiftUI
import WebKit


struct ContentView: View {
    @EnvironmentObject var appDelegate: AppDelegate
    @StateObject var spotifyManager = SpotifyApiManager()
    
    var body: some View {
        VStack {
            Text("try to get token")
                .onTapGesture {
                    let queryItems = [URLQueryItem(name: "client_id", value: spotifyManager.clientId), URLQueryItem(name: "response_type", value: "code"), URLQueryItem(name: "redirect_uri", value: "spotify-ios-quick-start://spotify-login-callback")]
                    var urlComps = URLComponents(string: "https://accounts.spotify.com/authorize?")!
                    urlComps.queryItems = queryItems
                    let result = urlComps.url!
                    print(result)
                    UIApplication.shared.open(result)
                }
            
            if let token = appDelegate.authToken {
                Text("Access Token: \(token)")
            } else {
                Text("No Access Token")
            }
        }
        
    }
}

struct WebView: UIViewRepresentable {
 
    let webView: WKWebView
    
    init() {
        webView = WKWebView(frame: .zero)
      
    }
    
    func makeUIView(context: Context) -> WKWebView {
        return webView
    }
    
    func updateUIView(_ uiView: WKWebView, context: Context) {
        let queryItems = [URLQueryItem(name: "client_id", value: spotifyManager.clientId), URLQueryItem(name: "response_type", value: "code"), URLQueryItem(name: "redirect_uri", value: "spotify-ios-quick-start://spotify-login-callback")]
        var urlComps = URLComponents(string: "https://accounts.spotify.com/authorize?")!
        urlComps.queryItems = queryItems
        let result = urlComps.url!
        print(result)
        UIApplication.shared.open(result)
        webView.load(URLRequest(url: URL(string: )!))
    }
}
