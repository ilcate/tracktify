//
//  SongInTop.swift
//  Tracktify
//
//  Created by Christian Catenacci on 06/08/24.
//

import SwiftUI
import SDWebImageSwiftUI

struct SongInTop: View {
    @EnvironmentObject var audioPlayer : AudioPlayer
    let song : Song
    
    var body: some View {
        HStack {
            WebImage(url: URL(string: song.album.images[1].url))
                .resizable()
                .indicator(.activity)
                .scaledToFit()
                .frame(width: 50, height: 50)
                .cornerRadius(4)
                .padding(.leading, 12)
                .padding(.vertical, 12)
            
            VStack (alignment:.leading){
                
                Text(song.name)
                    .foregroundStyle(.white)
                    .font(.title3)
                    .lineLimit(1)
                
                Text(song.artists[0].name)
                    .foregroundStyle(.white)
                    .font(.caption)
            }
            Spacer()
            Image(systemName: audioPlayer.isPlaying && song.name == audioPlayer.songInPlay  ? "pause.circle.fill" : "play.circle.fill")
                .font(.title)
                .padding(.trailing, 12)
                .onTapGesture {
                    audioPlayer.playSong(songToPlay: URL(string: song.preview_url)!, songName: song.name)
                }
        } .background(.white.opacity(0.1))
            .clipShape(RoundedRectangle(cornerRadius: 6))
            .frame(maxWidth: .infinity, minHeight: 80, maxHeight: 80)
            .padding(.bottom, -2)
            .padding(.horizontal, 12)
    }
    
}
