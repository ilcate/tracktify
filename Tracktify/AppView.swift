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
                        Image(systemName: "play.circle.fill")
                            .font(.title)
                            .padding(.trailing, 12)
                        
                    }
                    
                    .background(.white.opacity(0.1))
                    .clipShape(RoundedRectangle(cornerRadius: 6))
                    .frame(maxWidth: .infinity, minHeight: 80, maxHeight: 80)
                    .padding(.bottom, -2)
                    .padding(.horizontal, 12)
                    
                }
            }
        }
    }
}

