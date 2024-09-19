//
//  SongLyricsView.swift
//  Tracktify
//
//  Created by Christian Catenacci on 18/09/24.
//

import SwiftUI

struct SongLyricsView: View {
    @ObservedObject var geniusApiManager : GeniusApiManager
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8){
            HStack(alignment: .center){
                Text("Song Lyrics")
                    .normalTextStyle(fontName: "LeagueSpartan-Medium", fontSize: 18, fontColor: .accent)
                Spacer()
                Image(systemName: "arrow.up.left.and.arrow.down.right")
                    .font(.caption)
                    .overlay {
                        Circle()
                            .frame(width: 22, height: 22)
                            .opacity(0.2)
                    }
                    
            }
           
            Text(geniusApiManager.lyrics)
                .normalTextStyle(fontName: "LeagueSpartan-SemiBold", fontSize: 22, fontColor: .white)
        }
        .padding(16)
        .frame(height: 300)
        .background(.white.opacity(0.1))
        .clipShape(RoundedRectangle(cornerRadius: 12))
        .padding(.horizontal, 12)
    }
}

