import SwiftUI

struct GenresView: View {
    @EnvironmentObject var spotifyDataManager: SpotifyDataManager
    @Environment(\.dismiss) private var dismiss

    @State private var genreSearch = ""
    
    var body: some View {
        ZStack{
            VStack(alignment: .leading) {
                HStack(alignment: .bottom){
                    Title(titleText: "Select some genres", toExecute: spotifyDataManager.getMusicGenres)
                    Spacer()
                    Text("Cancel")
                        .normalTextStyle(fontName: "LeagueSpartan-SemiBold", fontSize: 17, fontColor: .accent)
                        .onTapGesture {
                            dismiss()
                        }
                        .padding(.trailing, 12)
                }.padding(.top, 20)
                    .padding(.bottom, 8)
//                    TextField(
//                           "search",
//                           text: $genreSearch
//                       )
                
                
                ScrollView(showsIndicators: false){
                    LazyVStack(alignment: .leading, spacing: 10) {
                        ForEach(groupItems(genreSearch == "" ? spotifyDataManager.spotifyGenres : spotifyDataManager.spotifyGenres.filter({ $0.contains(genreSearch)})), id: \.self) { rowItems in
                            HStack {
                                ForEach(rowItems, id: \.self) { item in
                                    Text(item)
                                        .normalTextStyle(fontName: "LeagueSpartan-SemiBold", fontSize: 18, fontColor: spotifyDataManager.selectedGenres.contains(item) ? .cBlack : .white )
                                        .padding(6)
                                        .background(spotifyDataManager.selectedGenres.contains(item) ? .accent : .white.opacity(0.1))
                                        .foregroundColor(.white)
                                        .cornerRadius(8)
                                        .onTapGesture{
                                            if spotifyDataManager.selectedGenres.contains(item) {
                                                let toRemove = spotifyDataManager.selectedGenres.lastIndex(of: item)
                                                spotifyDataManager.selectedGenres.remove(at: toRemove!)
                                            } else if spotifyDataManager.selectedGenres.count < 5 {
                                                spotifyDataManager.selectedGenres.append(item)
                                            }
                                            
                                        }
                                }
                            }
                        }
                    }
                    .padding(.horizontal, 12)
                    .padding(.bottom, 60)
                }
            }
            
            VStack{
                Spacer()
                NavigationLink {
                    AddFiltersView()
                        .background(.cBlack)
                } label: {
                    Text("Continue")
                        .normalTextStyle(fontName: "LeagueSpartan-SemiBold", fontSize: 20, fontColor: spotifyDataManager.selectedGenres.count > 0 ? .cBlack : .white)
                        .frame(maxWidth: .infinity, minHeight: 50)
                        .background(spotifyDataManager.selectedGenres.count > 0 ? .accent : .cdarkGray)
                        .clipShape(RoundedRectangle(cornerRadius: 1000))
                        .padding(.bottom, 0)
                        .padding(.horizontal, 12)

                }
               
            }
        }.navigationBarBackButtonHidden()
       
    }
    
    private func groupItems(_ items: [String]) -> [[String]] {
        var groupedItems: [[String]] = []
        var currentRow: [String] = []
        var currentRowWidth: CGFloat = 0
        let maxWidth: CGFloat = UIScreen.main.bounds.width - 24
        
        for item in items {
            let itemWidth = estimateTextWidth(item)
            
            if currentRowWidth + itemWidth > maxWidth {
                groupedItems.append(currentRow)
                currentRow = [item]
                currentRowWidth = itemWidth
            } else {
                currentRow.append(item)
                currentRowWidth += itemWidth
            }
        }
        
        if !currentRow.isEmpty {
            groupedItems.append(currentRow)
        }
        
        return groupedItems
    }
    
    private func estimateTextWidth(_ text: String) -> CGFloat {
        let font = UIFont.systemFont(ofSize: 18)
        let attributes = [NSAttributedString.Key.font: font]
        let size = (text as NSString).size(withAttributes: attributes)
        return size.width + 19
    }
}



//TODO: OPTIONAL try to divide genres in small categories to set them in some horizontal scroll view
