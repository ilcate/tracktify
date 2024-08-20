//
//  NewReleases.swift
//  Tracktify
//
//  Created by Christian Catenacci on 19/08/24.
//

import SwiftUI
import SDWebImageSwiftUI

struct NewReleasesView: View {
    @EnvironmentObject var spotifyDataManager: SpotifyDataManager
    
    var body: some View {
        VStack(alignment: .leading ,spacing: 10){
            Title(titleText: "New releases", toExecute: spotifyDataManager.getAlbumNewReleases)
            
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
                    
                } .scrollTargetLayout()
            }
            .scrollIndicators(.hidden)
            .contentMargins(12, for: .scrollContent)
            .scrollTargetBehavior(.viewAligned)
            .frame(maxWidth: .infinity, maxHeight: 120)
            .onAppear{
                print(spotifyDataManager.accessToken)
            }
        }
       
        
    }
}
