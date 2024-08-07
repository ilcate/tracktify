//
//  AppView.swift
//  Tracktify
//
//  Created by Christian Catenacci on 06/08/24.
//

import SwiftUI
import SDWebImageSwiftUI

struct AppView: View {
    @EnvironmentObject var spotifyDataManager : SpotifyDataManager
    
    
    var body: some View {
        VStack{
            HStack (alignment:.bottom){
                Text("Your Top Songs")
                    .font(.title)
                    .bold()
                    .onAppear{
                        spotifyDataManager.getMySpotifyTopTraks()
                    }
                Spacer()
                
                Text(spotifyDataManager.termOfTopTrack == 0 ? "last month" : spotifyDataManager.termOfTopTrack == 1 ? "last six month": "last year" )
                    .onTapGesture {
                        if spotifyDataManager.termOfTopTrack == 2 {
                            spotifyDataManager.termOfTopTrack = 0
                        }else{
                            spotifyDataManager.termOfTopTrack += 1
                        }
                        spotifyDataManager.getMySpotifyTopTraks()
                    }
                
                
            }
            .padding(.top, 28)
            .padding(.bottom, 8)
            .padding(.horizontal, 12)
            
            
            LazyVStack{
                ForEach(spotifyDataManager.yourTopTracks, id: \.self){ song in
                        SongInTop(song: song)
                    }
                   
                    
                }
            }
        }
}

