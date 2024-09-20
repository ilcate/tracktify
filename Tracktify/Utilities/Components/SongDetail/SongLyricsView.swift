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
        VStack(alignment: .leading){
            VStack{}.frame(height: 4)
            HStack(alignment: .center){
                Text("Song Lyrics")
                    .normalTextStyle(fontName: "LeagueSpartan-Bold", fontSize: 22, fontColor: .accent)
                Spacer()
                Image(systemName: "arrow.up.left.and.arrow.down.right")
                    .font(.caption)
                    .overlay {
                        Circle()
                            .frame(width: 22, height: 22)
                            .opacity(0.2)
                    }
                    
            }.padding(.bottom, 10)
           
            Text(geniusApiManager.lyrics)
                .normalTextStyle(fontName: "LeagueSpartan-Medium", fontSize: 20, fontColor: .white)
            Spacer()
        }
        .padding(.horizontal, 16)
        .frame(height: 300)
        .background(.white.opacity(0.1))
        .clipShape(RoundedRectangle(cornerRadius: 12))
        .padding(.horizontal, 12)
    }
}

