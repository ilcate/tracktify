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
        ForEach(array, id: \.self) { artist in
            HStack{
                WebImage(url: URL(string: artist.image_url!))
                    .resizable()
                    .frame(width: 30, height: 30)
                    .clipShape(RoundedRectangle(cornerRadius: 1000))
                Text(artist.name ?? "Unknown Artist")
                
            }
        }
    }
}

