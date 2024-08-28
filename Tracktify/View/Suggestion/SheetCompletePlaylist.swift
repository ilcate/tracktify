import SwiftUI

struct SheetCompletePlaylist: View {
    @EnvironmentObject var spotifyDataManager: SpotifyDataManager
    @Environment(\.dismiss) private var dismiss

    var body: some View {
        VStack(alignment: .leading){
            Text("Set up your preferences")
                .normalTextStyle(fontName:" LeagueSpartan-SemiBold", fontSize: 20, fontColor: .white)
            HStack{
                Text("Add a name")
                    .normalTextStyle(fontName:" LeagueSpartan-Medium", fontSize: 17, fontColor: .white)
                Spacer()
                TextField(
                       "Name here",
                       text: $spotifyDataManager.playlistName
                   )
            
            }
        }.padding(12)
        
        Text("Add to Spotify")
            .normalTextStyle(fontName: "LeagueSpartan-SemiBold", fontSize: 20, fontColor: .white)
            .frame(maxWidth: .infinity, minHeight: 50)
            .background(.accent)
            .clipShape(RoundedRectangle(cornerRadius: 12))
            .padding(.bottom, -8)
            .padding(.horizontal, 12)
            .onTapGesture {
                spotifyDataManager.createPlaylist()
                dismiss()
            }

        
            
    }
}


//TODO: sarebbe figo mandargli le immagini da qui
