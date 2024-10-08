import Foundation
import Alamofire
import SwiftSoup

class GeniusApiManager: ObservableObject {
    
    @Published var lyrics = ""
    @Published var songDet = GeniusSong(title: "", artist_names: "", producer_artists: [Person(image_url: "", name: "")], song_relationships: [SongRelationship(relationship_type: "", songs: [SmallSongInfo(artist_names: "", title: "")])], writer_artists: [Person(image_url: "", name: "")], featured_artists: [Person(image_url: "", name: "")], path: "")
    
    private let headers = HTTPHeaders(["Authorization": "Bearer Xc2KaTMA5d24LopQ4aC2DXRnqSgGLbrppnbLcjLLS-Uidik0JLqls73a0NhFPHja"])
    var selectedSong: ResultSearch = ResultSearch(id: 0, path: "")
    
    
    
    func searchSong(artistName: String, songName: String) {
        let query = "\(artistName.replacingOccurrences(of: " ", with: "%20").lowercased())%20\(songName.replacingOccurrences(of: " ", with: "%20").lowercased())"
        AF.request("https://api.genius.com/search?q=\(fixUrl(stringToFix: query))", method: .get, headers: headers)
            .validate(statusCode: 200..<300)
            .responseDecodable(of: GeniusResearch.self) { res in
                switch res.result {
                case .success(let results):
                    if  results.response.hits.count > 0 {
                        self.selectedSong = results.response.hits[0].result
                        self.searchInfoSong(songID: self.selectedSong.id)
                    }else {
                        self.selectedSong = ResultSearch(id: 0, path: "")
                    }
                case .failure(let error):
                    print(error)
                }
            }
    }
    
    private func searchInfoSong(songID: Int) {
        let url = "https://api.genius.com/songs/\(songID)"
        
        AF.request(url, method: .get, headers: headers)
            .validate(statusCode: 200..<300)
            .responseDecodable(of: SearchDetailSong.self) { [self] songDetail in
                switch songDetail.result {
                case .success(let results):
                    self.songDet = results.response.song
                    self.fetchLyrics(url: self.songDet.path)
                case .failure(let error):
                    print(error)
                }
            }
    }
    
    func fetchLyrics( url: String) {
        let endpoint = LyricEndpoint.getLyrics(fromUrl: url)
        let urlString = "\(endpoint.scheme)://\(endpoint.baseURL)\(endpoint.path)"
        print(urlString)
        
        AF.request(urlString, method: .get, parameters: endpoint.parameters.isEmpty ? nil : Dictionary(uniqueKeysWithValues: endpoint.parameters.map { ($0.name, $0.value) }), headers: headers).responseData { [weak self] response in
            switch response.result {
            case .success(let data):
                guard let self = self else { return }
                
                if let htmlString = String(data: data, encoding: .utf8) {
                    let songLyrics = extrachLyrics(from: htmlString)
                    
                    var resultString = ""
                    
                    if let range = songLyrics.range(of: "[Intro]") {
                        resultString = String(songLyrics[range.upperBound...])
                        lyrics = "[Intro]" + resultString
                    } else if let range = songLyrics.range(of: "1]") {
                        resultString = String(songLyrics[range.upperBound...])
                        lyrics = "[Verse 1]" + resultString
                    }else if let range = songLyrics.range(of: "[Pre-Chorus]") {
                        resultString = String(songLyrics[range.upperBound...])
                        lyrics = "[Pre-Chorus]" + resultString
                    } else {
                        lyrics = songLyrics
                    }
                    
                    
                    
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


private func fixUrl(stringToFix: String) -> String {
    let accentMappings: [Character: Character] = [
        "à": "a", "è": "e", "é": "e", "ì": "i", "ò": "o", "ù": "u",
        "À": "A", "È": "E", "É": "E", "Ì": "I", "Ò": "O", "Ù": "U"
    ]
    var fixedString = stringToFix.map { accentMappings[$0] ?? $0 }.map(String.init).joined()
    
    if let range = fixedString.range(of: "%20from", options: .caseInsensitive) {
        fixedString = String(fixedString[..<range.lowerBound])
    }
    if let range = fixedString.range(of: "%20(feat", options: .caseInsensitive) {
        fixedString = String(fixedString[..<range.lowerBound])
    }

    return fixedString
}
