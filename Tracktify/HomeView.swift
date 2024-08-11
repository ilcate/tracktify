//
//  AppView.swift
//  Tracktify
//
//  Created by Christian Catenacci on 06/08/24.
//



//HStack (alignment:.bottom){
//                Text("Your Top Songs")
//                    .font(.title)
//                    .bold()
//                    .onAppear{
//                        spotifyDataManager.getMySpotifyTopTraks()
//                    }
//                Spacer()
//
//                Text(spotifyDataManager.termOfTopTrack == 0 ? "last month" : spotifyDataManager.termOfTopTrack == 1 ? "last six month": "last year" )
//                    .onTapGesture {
//                        if spotifyDataManager.termOfTopTrack == 2 {
//                            spotifyDataManager.termOfTopTrack = 0
//                        }else{
//                            spotifyDataManager.termOfTopTrack += 1
//                        }
//                        spotifyDataManager.getMySpotifyTopTraks()
//                    }
//
//
//            }
//            .padding(.top, 28)
//            .padding(.bottom, 8)
//            .padding(.horizontal, 12)
//
//
//            LazyVStack{
//                ForEach(spotifyDataManager.yourTopTracks, id: \.self){ song in
//                        SongInTop(song: song)
//                    }
//
//                }


import SwiftUI
import SDWebImageSwiftUI

struct HomeView: View {
    @EnvironmentObject var spotifyDataManager: SpotifyDataManager
    @State private var currentDate: String = ""
    
    var body: some View {
        VStack(alignment: .leading, spacing: 20) {
            HStack {
                VStack(alignment: .leading, spacing: 4) {
                    Text("Hi \(spotifyDataManager.username)")
                        .normalTextStyle(fontName: "LeagueSpartan-Bold", fontSize: 30, fontColor: .white)
                    Text(currentDate)
                        .normalTextStyle(fontName: "LeagueSpartan-Regular", fontSize: 18, fontColor: .accent)
                }
                Spacer()
                WebImage(url: URL(string: spotifyDataManager.profilePicture))
                    .resizable()
                    .scaledToFit()
                    .frame(width: 44, height: 44)
                    .cornerRadius(1000)
            }
            .padding(.horizontal, 12)
            .padding(.top, 20)
            .onAppear {
                spotifyDataManager.getMySpotifyInformation()
                updateCurrentDate()
            }
            
            Text("New releases")
                .normalTextStyle(fontName: "LeagueSpartan-SemiBold", fontSize: 24, fontColor: .white)
                .onAppear{
                    spotifyDataManager.getAlbumNewReleases()
                }.padding(.horizontal, 12)
            ScrollView(.horizontal){
                LazyHStack{
                    ForEach(spotifyDataManager.newReleasedAlbums, id: \.self){ albums in
                        HStack{
                            WebImage(url: URL(string: albums.images[albums.images.count-1].url))
                                .resizable()
                                .scaledToFit()
                                .frame(width: 106, height: 106)
                                .cornerRadius(6)
                                .padding(.leading, 8)
                                
                            VStack(alignment: .leading){
                                Text(albums.name)
                                    .normalTextStyle(fontName: "LeagueSpartan-SemiBold", fontSize: 26, fontColor: .white)
                                
                                Text(albums.artists[0].name)
                                    .normalTextStyle(fontName: "LeagueSpartan-Medium", fontSize: 20, fontColor: .accent)
                                
                                Spacer()
                                Text("Released on \(albums.release_date)")
                                    .normalTextStyle(fontName: "LeagueSpartan-Medium", fontSize: 16, fontColor: .white)
                            }
                            .padding(.vertical, 14)
                            Spacer()
                            
                        }
                        .background(.white.opacity(0.1))
                        .clipShape(RoundedRectangle(cornerRadius: 12))
                        .frame(width: 360, height: 120)
                           
                    }
                    
                }
            }
            .padding(.horizontal, 12)
            
            
            
            
            Spacer()
        }
        
    }
    
    private func updateCurrentDate() {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "EEE d MMM"
        currentDate = dateFormatter.string(from: Date())
    }
}
