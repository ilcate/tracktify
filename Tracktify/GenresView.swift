import SwiftUI

struct GenresView: View {
    @EnvironmentObject var spotifyDataManager: SpotifyDataManager
    @State private var genreSearch = ""
    
    var body: some View {
        ZStack{
            VStack(alignment: .leading) {
                Title(titleText: "Select some genres", toExecute: spotifyDataManager.getMusicGenres)
                    TextField(
                           "search",
                           text: $genreSearch
                       )
                
                
                ScrollView {
                    LazyVStack(alignment: .leading, spacing: 10) {
                        ForEach(groupItems(genreSearch == "" ? spotifyDataManager.spotifyGenres : spotifyDataManager.spotifyGenres.filter({ $0.contains(genreSearch)})), id: \.self) { rowItems in
                            HStack {
                                ForEach(rowItems, id: \.self) { item in
                                    Text(item)
                                        .normalTextStyle(fontName: "LeagueSpartan-SemiBold", fontSize: 18, fontColor:  .white )
                                        .padding(6)
                                        .background(spotifyDataManager.selectedGenres.contains(item) ? .accent : .white.opacity(0.5))
                                        .foregroundColor(.white)
                                        .cornerRadius(8)
                                        .overlay(
                                            RoundedRectangle(cornerRadius: 8)
                                                .stroke(.accent, lineWidth: 2)
                                        )
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
                    .padding()
                }
            }
            
            VStack{
                Spacer()
                NavigationLink {
                    AddFiltersView()
                        .background(.cBlack)
                } label: {
                    Text("Continue")
                        .normalTextStyle(fontName: "LeagueSpartan-SemiBold", fontSize: 20, fontColor: .white)
                        .frame(maxWidth: .infinity, minHeight: 60)
                        .background(spotifyDataManager.selectedGenres.count > 0 ? .accent : .gray)
                        .clipShape(RoundedRectangle(cornerRadius: 12))
                        .padding(.bottom, -8)
                        .padding(.horizontal, 12)

                }
               
            }
        }
       
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
