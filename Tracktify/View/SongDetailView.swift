//
//  SongDetailView.swift
//  Tracktify
//
//  Created by Christian Catenacci on 29/08/24.
//

import SwiftUI
import SDWebImageSwiftUI

struct SongDetailView: View {
    @Binding var songToDisplay : Song
    @State var sel = true
    
    @State var height : CGFloat = 0
    @State var aritstNames : String = ""
    @EnvironmentObject var spotifyDataManager: SpotifyDataManager
    @StateObject var lyricsManager = LyricsManager()
    @StateObject var geniusApiManager = GeniusApiManager()
    
    var body: some View {
        VStack {
            if height < 250 {
                Spacer()
            }
            MacroSongDetail(songToDisplay: $songToDisplay, aritstNames: $aritstNames)
            
            VStack {
                if height < 300 {
                    Text("Drag up for more")
                        .normalTextStyle(fontName: "LeagueSpartan-Bold", fontSize: 18, fontColor: .accent)
                } else {
                    if (songToDisplay.artists[0].genres?.isEmpty ?? true) {
                        ZStack {
                            ScrollView(showsIndicators: false){
                                VStack(spacing: 16){
                                    
                                    //TODO: sarebbe figo mettere una cosa che ti dica la popolarità e altro
                                    ProducerAndWriterView( geniusApiManager: geniusApiManager)
                                    SongLyricsView(geniusApiManager: geniusApiManager)
                                    
                                }    .padding(.bottom, 24)
                               
                            }
                            
                            VStack {
                                VStack {}.frame(maxWidth: .infinity, minHeight: 4).background(.cdarkGray)
                                Spacer()
                            }
                        }
                    }
                }
            }.padding(.top, 12)
            
            Spacer()
        }
        .modifier(GetHeightModifier(height: $height))
        .ignoresSafeArea(.all)
        .onAppear {
            var aritstArray: [String] = []
            aritstArray = songToDisplay.artists.map { $0.name }
            aritstNames = aritstArray.joined(separator: ", ")
            
            geniusApiManager.searchSong(artistName: songToDisplay.artists[0].name, songName: songToDisplay.name)
        }
    }
}

func convertMStoM(milliseconds: Float) -> String {
    let seconds = milliseconds / 1000
    let minutes = Int(seconds / 60)
    let remainingSeconds = Int(seconds.truncatingRemainder(dividingBy: 60))
    
    return String(format: "%d:%02d", minutes, remainingSeconds)
}

