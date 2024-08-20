import SwiftUI
import SDWebImageSwiftUI

struct HomeView: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 20) {
            HomeHeaderView()
                .padding(.bottom, 4)
            NewReleasesView()
            RecentlyPlayedView()
                
            
            
            
            
            Spacer()
        }
        
        
    }
    
}
