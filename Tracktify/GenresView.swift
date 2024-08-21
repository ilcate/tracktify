import SwiftUI

struct GenresView: View {
    @EnvironmentObject var spotifyDataManager: SpotifyDataManager
    
    var body: some View {
        VStack(alignment: .leading) {
            Title(titleText: "Select some genres", toExecute: spotifyDataManager.getMusicGenres)
            
            ScrollView {
                LazyVStack(alignment: .leading, spacing: 10) {
                    ForEach(groupItems(spotifyDataManager.spotifyGenres), id: \.self) { rowItems in
                        HStack {
                            ForEach(rowItems, id: \.self) { item in
                                Text(item)
                                    .normalTextStyle(fontName: "LeagueSpartan-SemiBold", fontSize: 18, fontColor: .white)
                                    .padding(6)
                                    .background(.white.opacity(0.5))
                                    .foregroundColor(.white)
                                    .cornerRadius(8)
                                    .overlay(
                                        RoundedRectangle(cornerRadius: 8)
                                            .stroke(.accent, lineWidth: 2)
                                    )
                            }
                        }
                    }
                }
                .padding()
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
