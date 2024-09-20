//
//  TopSongsHomeView.swift
//  Tracktify
//
//  Created by Christian Catenacci on 20/09/24.
//

import SwiftUI
import SDWebImageSwiftUI

struct TopSongsHomeView: View {
    @EnvironmentObject var spotifyDataManager : SpotifyDataManager
    @EnvironmentObject var audioPlayer : AudioPlayer
    @State var selectedSong : Song = Song(id: "", name: "", uri: "", preview_url: "", explicit: false, artists: [Artist(id: "", name: "")], album: Album(id: "", name: "", total_tracks: 0, images: [ImageFetch(url: "")]), duration_ms: 0)
     
    @State var sheetSong = false
    
    var body: some View {
        VStack {
            HStack(alignment: .bottom){
                Title(titleText: "Top of Last \(spotifyDataManager.termOfTopTrack == 0 ? "Month" : spotifyDataManager.termOfTopTrack == 1 ? "Six Month": "Year" )", toExecute: spotifyDataManager.getMySpotifyTopTraks)
                Spacer()
                Text("See other")
                    .normalTextStyle(fontName: "LeagueSpartan-SemiBold", fontSize: 16, fontColor: .accent)
                    .padding(.trailing, 12)
                    .onTapGesture {
                        if spotifyDataManager.termOfTopTrack == 2 {
                            spotifyDataManager.termOfTopTrack = 0
                        }else{
                            spotifyDataManager.termOfTopTrack += 1
                        }
                        spotifyDataManager.getMySpotifyTopTraks()
                    }
            }
            
            
            LazyVStack {
                ForEach(Array(spotifyDataManager.yourTopTracks.enumerated()), id: \.element) { index, song in
                    VStack {
                        HStack {
                            HStack {
                                Text("\(index + 1)")
                                    .normalTextStyle(fontName: "LeagueSpartan-SemiBold", fontSize: 20, fontColor: .accent)
                                
                                WebImage(url: URL(string: song.album.images[0].url))
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 44, height: 44)
                                    .cornerRadius(6)
                                VStack(alignment: .leading) {
                                    Text(song.name)
                                        .normalTextStyle(fontName: "LeagueSpartan-Medium", fontSize: 20, fontColor: .white)
                                        .lineLimit(1)
                                    Text(song.artists[0].name)
                                        .normalTextStyle(fontName: "LeagueSpartan-SemiBold", fontSize: 16, fontColor: .accent)
                                }
                            }.onTapGesture {
                                selectedSong = song
                                sheetSong.toggle()
                            }
                            
                            Spacer()
                            Image(systemName: audioPlayer.isPlaying && song.name == audioPlayer.songInPlay  ? "stop.circle.fill" : "play.circle.fill")
                                .font(.title)
                                .onTapGesture {
                                    if audioPlayer.songInPlay != song.name{
                                        audioPlayer.playSong(songToPlay: URL(string: song.preview_url!)!, songName: song.name)
                                    } else if audioPlayer.isPlaying {
                                        audioPlayer.pauseSong()
                                    } else {
                                        audioPlayer.playSong(songToPlay: URL(string: song.preview_url!)!, songName: song.name)
                                    }
                                }
                        }
                        .padding(.top, index == 0 ? 0 : 2.2)
                        .padding(.bottom, index == 4 ? 0 : 2.2)

                        if index < 4 {
                            Divider()
                                .frame(height: 1.6)
                                .background(Color.white.opacity(0.3))
                        }
                    }
                }
            }.padding(.horizontal, 12)
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


