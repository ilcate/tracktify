//
//  SuggestionView.swift
//  Tracktify
//
//  Created by Christian Catenacci on 21/08/24.
//

import SwiftUI
import SDWebImageSwiftUI


struct SuggestionView: View {
    @EnvironmentObject var spotifyDataManager: SpotifyDataManager
    @EnvironmentObject var audioPlayer: AudioPlayer
    @Environment(\.dismiss) private var dismiss
    @State var sheetAddPlaylist = false
    
    var body: some View {
        ZStack{
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
                        
                    Title(titleText: "Suggestion for you", toExecute: spotifyDataManager.getSuggestions)
                    Spacer()
                }
                .padding(.top, 16)
                
                ScrollView {
                    ForEach(Array(spotifyDataManager.suggestions.enumerated()), id: \.0) { index, song in
                        HStack {
                            Image(systemName: "trash.circle")
                                .onTapGesture {
                                    spotifyDataManager.suggestions.remove(at: index)
                                    spotifyDataManager.uris.remove(at: index)
                                }
                            
                            HStack {
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
                            }
                            Spacer()
                            Image(systemName: audioPlayer.isPlaying && song.name == audioPlayer.songInPlay  ? "stop.circle.fill" : "play.circle.fill")
                                .font(.title)
                                .onTapGesture {
                                    if audioPlayer.songInPlay != song.name {
                                        audioPlayer.playSong(songToPlay: URL(string: song.preview_url ?? "https://p.scdn.co/mp3-preview/ecc6383aac4b3f4240ae699324573e61c39e6aaf?cid=cfe923b2d660439caf2b557b21f31221")!, songName: song.name)
                                    } else if audioPlayer.isPlaying {
                                        audioPlayer.pauseSong()
                                    } else {
                                        audioPlayer.playSong(songToPlay: URL(string: song.preview_url ?? "https://p.scdn.co/mp3-preview/ecc6383aac4b3f4240ae699324573e61c39e6aaf?cid=cfe923b2d660439caf2b557b21f31221")!, songName: song.name)
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
            
            VStack{
                Spacer()
                Text("Add to Spotify")
                    .normalTextStyle(fontName: "LeagueSpartan-SemiBold", fontSize: 20, fontColor: .white)
                    .frame(maxWidth: .infinity, minHeight: 50)
                    .background(spotifyDataManager.selectedGenres.count > 0 ? .accent : .gray)
                    .clipShape(RoundedRectangle(cornerRadius: 12))
                    .padding(.bottom, -8)
                    .padding(.horizontal, 12)
                    .onTapGesture {
                        sheetAddPlaylist.toggle()
                    }
            }
            .sheet(isPresented: $sheetAddPlaylist) {
                SheetCompletePlaylist()
                    .presentationDetents([.fraction(0.48)])
            }
        }
        
        
    }
}

//TODO: fix bruttino da cambiare, ho messo un default a caso
