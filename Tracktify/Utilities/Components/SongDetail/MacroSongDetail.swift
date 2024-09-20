//
//  MacroSongDetail.swift
//  Tracktify
//
//  Created by Christian Catenacci on 20/09/24.
//

import SwiftUI
import SDWebImageSwiftUI

struct MacroSongDetail: View {
    @EnvironmentObject var spotifyDataManager: SpotifyDataManager
    @Binding var songToDisplay : Song
    @Binding var aritstNames : String
    
    var body: some View {
        VStack {
            HStack(alignment: .top, spacing: 12) {
                WebImage(url: URL(string: songToDisplay.album.images[0].url))
                    .resizable()
                    .scaledToFill()
                    .frame(width: 140, height: 140)
                    .cornerRadius(10)
                
                VStack(alignment: .leading, spacing: 5) {
                    Text(songToDisplay.album.name)
                        .normalTextStyle(fontName: "LeagueSpartan-Medium", fontSize: 18, fontColor: .white.opacity(0.5))
                        .padding(.top, 10)
                    Text(songToDisplay.name)
                        .normalTextStyle(fontName: "LeagueSpartan-ExtraBold", fontSize: 26, fontColor: .white)
                        .lineLimit(1)
                    Text(aritstNames)
                        .normalTextStyle(fontName: "LeagueSpartan-SemiBold", fontSize: 22, fontColor: .accent)
                        .lineLimit(1)
                    Text(songToDisplay.explicit ? "Explicit" : "")
                        .normalTextStyle(fontName: "LeagueSpartan-SemiBold", fontSize: 16, fontColor: .white)
                        .lineLimit(1)
                    Spacer()
                    Text("Duration: \(convertMStoM(milliseconds: songToDisplay.duration_ms))")
                        .normalTextStyle(fontName: "LeagueSpartan-Medium", fontSize: 18, fontColor: .white.opacity(0.5))
                        .padding(.bottom, 6)
                }.frame(height: 140)
                
                Spacer()
            }
            .padding(.horizontal, 12)
        }
        .padding(.top, 24)
    }
}

