import SwiftUI

struct TopView: View {
    @State private var array: [String] = []
    @EnvironmentObject var spotifyDataManager: SpotifyDataManager
    
    var body: some View {
        
        
        
        VStack {
            HStack (alignment:.bottom){
                Text("Your Top Songs")
                    .font(.title)
                    .bold()
                    .onAppear{
                        spotifyDataManager.getMySpotifyTopTraks()
                    }
                Spacer()
                
                Text(spotifyDataManager.termOfTopTrack == 0 ? "last month" : spotifyDataManager.termOfTopTrack == 1 ? "last six month": "last year" )
                    .onTapGesture {
                        if spotifyDataManager.termOfTopTrack == 2 {
                            spotifyDataManager.termOfTopTrack = 0
                        }else{
                            spotifyDataManager.termOfTopTrack += 1
                        }
                        spotifyDataManager.getMySpotifyTopTraks()
                    }
                
                
            }
            .padding(.top, 28)
            .padding(.bottom, 8)
            .padding(.horizontal, 12)
            
            
            LazyVStack{
                ForEach(spotifyDataManager.yourTopTracks, id: \.self){ song in
                    SongInTop(song: song)
                }
                
            }
            
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
}

func randomString(length: Int) -> String {
    let characters = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
    return String((0..<length).map { _ in characters.randomElement()! })
}
