//
//  HomeHeader.swift
//  Tracktify
//
//  Created by Christian Catenacci on 19/08/24.
//

import SwiftUI
import SDWebImageSwiftUI

struct HomeHeaderView: View {
    @EnvironmentObject var spotifyDataManager: SpotifyDataManager
    @State private var currentDate: String = ""
    
    var body: some View {
        HStack {
            VStack(alignment: .leading, spacing: 4) {
                Text("Hi \(spotifyDataManager.username)")
                    .normalTextStyle(fontName: "LeagueSpartan-Bold", fontSize: 30, fontColor: .white)
                Text(currentDate)
                    .normalTextStyle(fontName: "LeagueSpartan-Regular", fontSize: 18, fontColor: .accent)
            }
            Spacer()
            WebImage(url: URL(string: spotifyDataManager.profilePicture))
                .resizable()
                .scaledToFit()
                .frame(width: 44, height: 44)
                .cornerRadius(1000)
        }
        .padding(.horizontal, 12)
        .padding(.top, 20)
        .onAppear {
            spotifyDataManager.getMySpotifyInformation()
            updateCurrentDate()
        }
        
    }
    
    private func updateCurrentDate() {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "EEE d MMM"
        currentDate = dateFormatter.string(from: Date())
    }
}

