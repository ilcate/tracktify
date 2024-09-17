import Foundation
import Alamofire
import SwiftSoup

class GeniusApiManager: ObservableObject {
    private let headers = HTTPHeaders(["Authorization": "Bearer Xc2KaTMA5d24LopQ4aC2DXRnqSgGLbrppnbLcjLLS-Uidik0JLqls73a0NhFPHja"])
    var selectedSong: ResultSearch = ResultSearch(id: 0, path: "")
    
    func searchSong(artistName: String, songName: String) {
        let query = "\(artistName.replacingOccurrences(of: " ", with: "%20").lowercased())%20\(songName.replacingOccurrences(of: " ", with: "%20").lowercased())"
        let url = "https://api.genius.com/search?q=\(query)"
        
        AF.request(url, method: .get, headers: headers)
            .validate(statusCode: 200..<300)
            .responseDecodable(of: GeniusResearch.self) { res in
                switch res.result {
                case .success(let results):
                    self.selectedSong = results.response.hits[0].result
                    self.searchInfoSong(songID: self.selectedSong.id)
                    print(self.selectedSong.id)
                case .failure(let error):
                    print(error)
                }
            }
    }
    
    private func searchInfoSong(songID: Int) {
        let url = "https://api.genius.com/songs/\(songID)"
        
        AF.request(url, method: .get, headers: headers)
            .validate(statusCode: 200..<300)
            .responseDecodable(of: SearchDetailSong.self) { songDetail in
                print(songDetail)
            }
    }
    
    func fetchLyrics(from url: String) {
        let endpoint = LyricEndpoint.getLyrics(fromUrl: url)
        let urlString = "\(endpoint.scheme)://\(endpoint.baseURL)\(endpoint.path)"
        print(urlString)
        
        AF.request(urlString, method: .get, parameters: endpoint.parameters.isEmpty ? nil : Dictionary(uniqueKeysWithValues: endpoint.parameters.map { ($0.name, $0.value) }), headers: headers).responseData { [weak self] response in
            switch response.result {
            case .success(let data):
                guard let self = self else { return }
                
                if let htmlString = String(data: data, encoding: .utf8) {
                    let songLyrics = extrachLyrics(from: htmlString)
                    
                    print(songLyrics)
                    
                   
                } else {
                    print("Failed to convert data to string.")
                }
                
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}

func extrachLyrics(from stringHtml: String) -> String {
    do {
        guard let body = getHtmlBody(from: stringHtml) else {
            return ""
        }
        
        let rawLyrics = try body.select("#lyrics-root").text()
        let lyrics = getFormatted(lyrics: rawLyrics)
        
        return lyrics
    } catch {
        return ""
    }
}

func getFormatted(lyrics: String) -> String {
    let startPattern = "\\["
    let endPattern = "\\]"
    let startPatternResult = lyrics.replacingOccurrences(of: startPattern, with: "\n\n[", options: .regularExpression, range: nil)
    let endPatternResult = startPatternResult.replacingOccurrences(of: endPattern, with: "]\n", options: .regularExpression, range: nil)
    return endPatternResult
}

private func getHtmlBody(from stringHtml: String) -> Elements? {
    do {
        let doc: Document = try SwiftSoup.parse(stringHtml)
        let body: Elements = try doc.select("body")
        return body
    } catch {
        return nil
    }
}
