import SwiftUI

@main
struct TracktifyApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(appDelegate)
        }
    }
}

class AppDelegate: NSObject, UIApplicationDelegate, ObservableObject {
    @Published var authToken: String?

    func application(_ application: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey : Any] = [:]) -> Bool {
        if url.scheme == "spotify-ios-quick-start" {
            handleSpotifyCallback(url: url)
            return true
        }
        return false
    }

    private func handleSpotifyCallback(url: URL) {
        guard let components = URLComponents(url: url, resolvingAgainstBaseURL: false),
              let code = components.queryItems?.first(where: { $0.name == "code" })?.value else {
            print("No authorization code found in callback URL")
            return
        }
        print("Authorization Code: \(code)")
        exchangeCodeForToken(code: code)
    }

    private func exchangeCodeForToken(code: String) {
        let tokenURL = URL(string: "https://accounts.spotify.com/api/token")!
        var request = URLRequest(url: tokenURL)
        request.httpMethod = "POST"

        let bodyParams = [
            "grant_type": "authorization_code",
            "code": code,
            "redirect_uri": "spotify-ios-quick-start://spotify-login-callback",
            "client_id": "your-client-id",
            "client_secret": "your-client-secret"
        ]

        request.httpBody = bodyParams
            .map { "\($0.key)=\($0.value)" }
            .joined(separator: "&")
            .data(using: .utf8)
        request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")

        URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data, error == nil else {
                print("Error during token request: \(error?.localizedDescription ?? "Unknown error")")
                return
            }

            do {
                if let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any],
                   let accessToken = json["access_token"] as? String {
                    DispatchQueue.main.async {
                        self.authToken = accessToken
                        print("Access Token: \(accessToken)")
                    }
                }
            } catch {
                print("Error parsing token response: \(error.localizedDescription)")
            }
        }.resume()
    }
}
