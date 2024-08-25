import SwiftUI

struct AddFiltersView: View {
    @EnvironmentObject var spotifyDataManager: SpotifyDataManager
    
    
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("Adjust with your preferences")
                .normalTextStyle(fontName: "LeagueSpartan-SemiBold", fontSize: 20, fontColor: .white)
            Spacer()
            HStack {
                Text("How many songs do you want?")
                Spacer()
                TextField("1", value: $spotifyDataManager.songQuantity, formatter: NumberFormatter())
                    .keyboardType(.numberPad)
                    .onChange(of: spotifyDataManager.songQuantity) { oldValue, newValue in
                        if newValue <= 0 {
                            spotifyDataManager.songQuantity = 1
                        } else if newValue > 100 {
                            spotifyDataManager.songQuantity = 100
                        }
                    }
                    .multilineTextAlignment(.trailing)
                    .padding()
                    .background(Color.gray.opacity(0.2))
                    .cornerRadius(5)
                
                
                
                
            }
            
            VStack{
                Text("How much energy you want?")
                Slider(
                    value: $spotifyDataManager.energy,
                    in: 0...80,
                    onEditingChanged: { editing in
                        spotifyDataManager.isEditing = editing
                    }
                )
            }
            
            HStack {
                Text("Would you dance on it?")
                Spacer()
                Text(spotifyDataManager.danceOnPlaylist ? "Yes" : "No")
                    .onTapGesture {
                        spotifyDataManager.danceOnPlaylist.toggle()
                    }
                
            }
            
            
            HStack {
                
                Picker("Select popularity", selection: $spotifyDataManager.selection) {
                    ForEach(spotifyDataManager.possibilities, id: \.self) {
                        Text($0)
                    }
                }.pickerStyle(.segmented)
            }
            
            
            NavigationLink {
                SuggestionView()
                    .background(.cBlack)
            } label: {
                Text("Continue")
                    .normalTextStyle(fontName: "LeagueSpartan-SemiBold", fontSize: 20, fontColor: .white)
                    .frame(maxWidth: .infinity, minHeight: 60)
                    .clipShape(RoundedRectangle(cornerRadius: 12))
                    .padding(.bottom, -8)
                    .padding(.horizontal, 12)

            }
            
            Spacer()
        }
    }
}
