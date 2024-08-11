import Foundation

enum APIConstants {
    static let clientID = "a27c3c02618c452a8ed4976bdcc07e80"
    static let clientSecret = "023ec65354734826a823981a8fd2e545"
    static let apiHost = "api.spotify.com"
    static let authHost = "accounts.spotify.com"
    static let redirectUri = "https://www.google.com"
    static let responseType = "token"
    static let scope = "user-top-read user-read-private user-read-email"
    
    static var authParams = [
        "response_type": responseType,
        "client_id": clientID,
        "redirect_uri": redirectUri,
        "scope": scope
    ]
    
}
