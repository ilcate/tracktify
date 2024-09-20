import SwiftUI
import SDWebImageSwiftUI

struct SuggestView: View {
    @EnvironmentObject var spotifyDataManager: SpotifyDataManager
    
  
    
    var body: some View {
        ScrollView(showsIndicators: false){
            VStack {
                Image("SuggestionIllustration")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 250)
                    .padding(.top, 26)
                    .padding(.bottom, 16)
                
                VStack(spacing: 6) {
                    Text("We know that create the ")
                        .normalTextStyle(fontName: "LeagueSpartan-Medium", fontSize: 20, fontColor: .white)
                    Text("perfect playlist can take forever!")
                        .normalTextStyle(fontName: "LeagueSpartan-Medium", fontSize: 20, fontColor: .white)
                    Text("Let us help you")
                        .normalTextStyle(fontName: "LeagueSpartan-Medium", fontSize: 20, fontColor: .white)
                }
                .padding(.bottom, 16)
                
                NavigationLink {
                    GenresView()
                        .background(.cBlack)
                } label: {
                    Text("Begin now!")
                        .normalTextStyle(fontName: "LeagueSpartan-Bold", fontSize: 20, fontColor: .cBlack)
                        .padding()
                        .background(.accent)
                        .clipShape(RoundedRectangle(cornerRadius: 10))
                }
                
                NewReleasesView()
                    .padding(.top, 12)
                
                HStack {
                    Title(titleText: "Trending Playlist", toExecute: spotifyDataManager.mostStreamedPlaylist)
                    Spacer()
                }.padding(.top, 20)
                
                VStack(spacing: 10) {
                    ForEach(0..<2) { rowIndex in
                        HStack(spacing: 10) {
                            ForEach(0..<2) { columnIndex in
                                let index = rowIndex * 2 + columnIndex
                                if index < spotifyDataManager.playlistInItaly.count {
                                    let playlist = spotifyDataManager.playlistInItaly[index]
                                    HStack {
                                        WebImage(url: URL(string: playlist.images[playlist.images.count - 1].url))
                                            .resizable()
                                            .scaledToFit()
                                            .frame(width: 44, height: 44)
                                            .cornerRadius(6)
                                            .padding(.leading, 8)
                                        Text(playlist.name)
                                            .normalTextStyle(fontName: "LeagueSpartan-Medium", fontSize: 18, fontColor: .white)
                                            .padding(.trailing, 8)
                                        Spacer()
                                    }
                                    .padding(.vertical, 8)
                                    .frame(maxWidth: .infinity)
                                    .background(.white.opacity(0.1))
                                    .clipShape(RoundedRectangle(cornerRadius: 8))
                                    
                                    
                                }
                            }
                        }
                    }
                }.padding(.horizontal, 12)
                
                Spacer()
                
                
            }
        }
        
    }
}
