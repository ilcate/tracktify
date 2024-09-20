//
//  PersonInformationView.swift
//  Tracktify
//
//  Created by Christian Catenacci on 18/09/24.
//

import SwiftUI
import SDWebImageSwiftUI

struct PersonInformationView: View {
    var array: [Person]
    
    var body: some View {
        
        ForEach(array.prefix(4), id: \.self) { artist in
            HStack(alignment: .center){
                if let imageUrl = artist.image_url, let url = URL(string: imageUrl) {
                    WebImage(url: url)
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: 37, height: 37)
                        .clipShape(RoundedRectangle(cornerRadius: 1000))
                }
                Text(artist.name ?? "Unknown Artist")
                    .normalTextStyle(fontName: "LeagueSpartan-Medium", fontSize: 20, fontColor: .white)
            }.padding(.top, 8)
        }
    }
}
