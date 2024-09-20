import SwiftUI

struct TopView: View {
    @State private var array: [String] = []
    @EnvironmentObject var spotifyDataManager: SpotifyDataManager
    
    var body: some View {
         
            if array.count > 0 {
                HStack {
                    ForEach(0..<min(array.count, 3), id: \.self) { index in
                        Text(array[index])
                    }
                }
            }
            
            if array.count > 3 {
                HStack {
                    ForEach(3..<min(array.count, 5), id: \.self) { index in
                        Text(array[index])
                    }
                }
            }
            
            if array.count < 5 {
                Button(action: {
                    array.append(randomString(length: 8))
                }) {
                    Text("Aggiungi")
                        .foregroundColor(.blue)
                }
            }
        }
    }


func randomString(length: Int) -> String {
    let characters = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
    return String((0..<length).map { _ in characters.randomElement()! })
}
