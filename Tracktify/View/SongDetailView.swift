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
    @State var selectionPoss = ["Song producer", "Song writers"]
    @State var sel = "Song producer"  // Match initial value with one from selectionPoss
    
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
            
            VStack {
                if height < 300 {
                    Text("Drag up for more")
                        .normalTextStyle(fontName: "LeagueSpartan-Bold", fontSize: 18, fontColor: .accent)
                } else {
                    if (songToDisplay.artists[0].genres?.isEmpty ?? true) {
                        ZStack {
                            ScrollView {
                                VStack{
                                    Picker("Song producer", selection: $sel) {
                                        ForEach(selectionPoss, id: \.self) {
                                            Text($0)
                                        }
                                    }.pickerStyle(.segmented)
                                    Spacer()
                                    if sel == "Song producer" {
                                        PersonInformationView(array: geniusApiManager.songDet.producer_artists ?? [])
                                    } else {
                                        PersonInformationView(array: geniusApiManager.songDet.writer_artists ?? [])
                                    }
                                }
                                .padding(16)
                                .frame(height: 200)
                                .background(.white.opacity(0.1))
                                .clipShape(RoundedRectangle(cornerRadius: 12))
                                .padding(.horizontal, 12).padding(.top, 12)
                                
                                
                                SongLyricsView(geniusApiManager: geniusApiManager)
                                    .padding(.bottom, 24)
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
            geniusApiManager.fetchLyrics(from: "/\(songToDisplay.artists[0].name.replacingOccurrences(of: " ", with: "-").replacingOccurrences(of: "'", with: "").lowercased())-\(songToDisplay.name.replacingOccurrences(of: " ", with: "-").replacingOccurrences(of: "'", with: "").lowercased())-lyrics")
        }
    }
}

func convertMStoM(milliseconds: Float) -> String {
    let seconds = milliseconds / 1000
    let minutes = Int(seconds / 60)
    let remainingSeconds = Int(seconds.truncatingRemainder(dividingBy: 60))
    
    return String(format: "%d:%02d", minutes, remainingSeconds)
}

