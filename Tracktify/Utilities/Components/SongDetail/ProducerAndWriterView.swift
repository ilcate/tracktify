//
//  ProducerAndWriterView.swift
//  Tracktify
//
//  Created by Christian Catenacci on 20/09/24.
//

import SwiftUI

struct ProducerAndWriterView: View {
    @State var sel = true 
    @StateObject var geniusApiManager : GeniusApiManager
    
    var body: some View {
        VStack(alignment: .leading, spacing: 0){
            VStack{}.frame(height: 12)
            HStack(alignment: .center){
                Text(sel ? "Song producers" : "Song writers")
                    .normalTextStyle(fontName: "LeagueSpartan-Bold", fontSize: 22, fontColor: .accent)
                Spacer()
                Image(systemName: "arrow.left.arrow.right")
                    .font(.caption)
                    .overlay {
                        Circle()
                            .frame(width: 22, height: 22)
                            .opacity(0.2)
                    }
                    .onTapGesture {
                        sel.toggle()
                    }
                    
            }.padding(.bottom, 2)
            
           
            if sel {
                PersonInformationView(array: geniusApiManager.songDet.producer_artists ?? [])
            } else {
                PersonInformationView(array: geniusApiManager.songDet.writer_artists ?? [])
            }
            
            Spacer()
        }
        .padding(.horizontal, 16)
        .frame(height: 230)
        .background(.white.opacity(0.1))
        .clipShape(RoundedRectangle(cornerRadius: 12))
        .padding(.horizontal, 12).padding(.top, 12)
    }
}

