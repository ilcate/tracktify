import SwiftUI
import SDWebImageSwiftUI

struct HomeView: View {
    var body: some View {
        
        VStack(alignment: .leading, spacing: 0) {
            HomeHeaderView()
                .padding(.bottom, 20)
            VStack {}.frame(maxWidth: .infinity, minHeight: 4).background(.cdarkGray)
            
            ScrollView(showsIndicators: false){
                VStack(alignment: .leading, spacing: 20) {
                    TopSongsHomeView()
                        .padding(.top, 12)
                    RecentlyPlayedView()
                    Spacer()
                }
                
                
            }
        }
        
        
        
    }
    
}
