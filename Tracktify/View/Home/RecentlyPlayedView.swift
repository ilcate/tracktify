//
//  RecentlyPlayedView.swift
//  Tracktify
//
//  Created by Christian Catenacci on 19/08/24.
//

import SwiftUI
import SDWebImageSwiftUI

struct RecentlyPlayedView: View {
    @EnvironmentObject var spotifyDataManager: SpotifyDataManager
    @EnvironmentObject var audioPlayer : AudioPlayer
    @State var sheetSong = false
    @State var selectedSong : Song = Song(id: "", name: "", uri: "", preview_url: "", explicit: false, artists: [Artist(id: "", name: "")], album: Album(id: "", name: "", total_tracks: 0, images: [ImageFetch(url: "")]), duration_ms: 0)
     
    
    var body: some View {
        VStack(alignment: .leading ,spacing: 10){
            HStack(alignment: .bottom){
                Title(titleText: "Recently Played", toExecute: spotifyDataManager.getSomeRecentlyPlayed)
                Spacer()
                NavigationLink {
                    ListRecentView()
                        .background(.cBlack)
                } label: {
                    Text("More")
                        .normalTextStyle(fontName: "LeagueSpartan-SemiBold", fontSize: 16, fontColor: .accent)
                        .padding(.trailing, 12)
                }

                
                
            }
            
            VStack {
                
                ForEach(Array(spotifyDataManager.recentlyPlayedSongs.enumerated()), id: \.element) { index, song in
                    VStack {
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
                            }.onTapGesture {
                                selectedSong = song.track
                                sheetSong.toggle()
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
                        .padding(.top, index == 0 ? 0 : 2.2)
                        .padding(.bottom, index == 2 ? 0 : 2.2)

                        if index == 0 || index == 1 {
                            Divider()
                                .frame(height: 1.6)
                                .background(Color.white.opacity(0.3))
                        }
                    }
                }
            }
            .padding(.horizontal, 12)
            .padding(.vertical, 10)
            .background(Color.white.opacity(0.1))
            .clipShape(RoundedRectangle(cornerRadius: 8))
            .padding(.horizontal, 12)
            .sheet(isPresented: $sheetSong) {
                SongDetailView(songToDisplay: $selectedSong)
                    .presentationDetents([.fraction(0.26), .large])
            }

            
        }
    }
}


