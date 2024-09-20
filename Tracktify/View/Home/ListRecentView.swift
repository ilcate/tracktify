//
//  ListRecentView.swift
//  Tracktify
//
//  Created by Christian Catenacci on 19/08/24.
//

import SwiftUI
import SDWebImageSwiftUI


struct ListRecentView: View {
    @EnvironmentObject var spotifyDataManager: SpotifyDataManager
    @EnvironmentObject var audioPlayer: AudioPlayer
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        VStack(alignment: .leading){
            HStack(alignment: .top, spacing: -4){
                Image(systemName: "chevron.backward")
                    .font(.title3)
                    .foregroundStyle(.accent)
                    .onTapGesture {
                        audioPlayer.pauseSong()
                        spotifyDataManager.recentlyPlayedSongs = []
                        dismiss()
                    }
                    .padding(.leading, 12)
                    
                Title(titleText: "Last Played Songs", toExecute: spotifyDataManager.getALotRecentlyPlayed)
                Spacer()
            }
            .padding(.top, 16)
            
            ScrollView(showsIndicators: false){
                ForEach(Array(spotifyDataManager.recentlyPlayedSongs.enumerated()), id: \.element) { index, song in
                        HStack {
                            HStack {
                                WebImage(url: URL(string: song.track.album.images[0].url))
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 44, height: 44)
                                    .cornerRadius(6)
                                VStack(alignment: .leading) {
                                    Text(song.track.name)
                                        .normalTextStyle(fontName: "LeagueSpartan-Medium", fontSize: 20, fontColor: .white)
                                        .lineLimit(1)
                                    Text(song.track.artists[0].name)
                                        .normalTextStyle(fontName: "LeagueSpartan-SemiBold", fontSize: 16, fontColor: .accent)
                                }
                            }
                            Spacer()
                            Image(systemName: audioPlayer.isPlaying && song.track.name == audioPlayer.songInPlay  ? "stop.circle.fill" : "play.circle.fill")
                                .font(.title)
                                .onTapGesture {
                                    if audioPlayer.songInPlay != song.track.name{
                                        audioPlayer.playSong(songToPlay: URL(string: song.track.preview_url!)!, songName: song.track.name)
                                    } else if audioPlayer.isPlaying {
                                        audioPlayer.pauseSong()
                                    } else {
                                        audioPlayer.playSong(songToPlay: URL(string: song.track.preview_url!)!, songName: song.track.name)
                                    }
                                    
                                }
                        }
                        .padding(.horizontal, 8)
                        .padding(.vertical, 6)
                        .background(.white.opacity(0.1))
                        .clipShape(RoundedRectangle(cornerRadius: 8))
                        .padding(.bottom, 6)
                        
                    }
                
            }.padding(.horizontal, 12)
        }
        .navigationBarBackButtonHidden()
        
    }
}

