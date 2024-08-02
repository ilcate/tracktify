import Foundation
import Alamofire

class SpotifyApiManager: ObservableObject {
    let clientId = "a27c3c02618c452a8ed4976bdcc07e80"
    let secretClientId = "023ec65354734826a823981a8fd2e545"
    
    
    
    
    func getSpotifyToken(){
        let tokenUrl = "https://accounts.spotify.com/api/token"
        let headersToken: HTTPHeaders = ["Content-Type": "application/x-www-form-urlencoded"]
        let parameters: [String: String] = [
            "grant_type": "client_credentials",
            "client_id": clientId,
            "client_secret": secretClientId
        ]

        AF.request(tokenUrl, method: .post, parameters: parameters, headers: headersToken)
            .validate(statusCode: 200..<300)
            .responseDecodable(of: ResponseSpotifyToken.self) { response in
                switch response.result {
                case .success(let succ):
                    print(succ.access_token)
                case.failure(let error):
                    print(error)
                }
            }
    }
    
    
}
