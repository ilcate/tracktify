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
    @State var height : CGFloat = 0
    @State var aritstNames : String = ""
    
    
    var body: some View {
        VStack{
            if height < 250 {
                Spacer()
            }
            HStack(alignment: .top, spacing: 12){
                WebImage(url: URL(string: songToDisplay.album.images[0].url))
                    .resizable()
                    .scaledToFill()
                    .frame(width: 140, height: 140)
                    .cornerRadius(10)

                VStack(alignment: .leading, spacing: 5){
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
                    Text("\(convertMStoM(milliseconds: songToDisplay.duration_ms))")
                        .normalTextStyle(fontName: "LeagueSpartan-Medium", fontSize: 18, fontColor: .white.opacity(0.5))
                        .padding(.bottom, 6)
                    
                    
                    
                }.frame(height: 140)
                
                Spacer()
            }.padding(.horizontal, 12)
            .padding(.top, 24)
               
            
            VStack{
                if height < 250 {
                    Text("Drag up for more")
                        .normalTextStyle(fontName: "LeagueSpartan-Bold", fontSize: 18, fontColor: .accent)
                    
                } else {
                    Text("More info")
                    
                    
                    
                }
            }.padding(.top, 12)
            
            Spacer()
            
        }.modifier(GetHeightModifier(height: $height))
            .onAppear{
                var aritstArray : [String] = []
                aritstArray = songToDisplay.artists.map{ $0.name }
                aritstNames = aritstArray.joined(separator: ", ")
                
            }
        
        
        
        
    }
}


func convertMStoM(milliseconds: Float) -> String {
    let seconds = milliseconds / 1000
    let minutes = Int(seconds / 60)
    let remainingSeconds = Int(seconds.truncatingRemainder(dividingBy: 60))
    
    return String(format: "%d:%02d", minutes, remainingSeconds)
}

