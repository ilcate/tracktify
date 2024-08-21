//
//  SuggestView.swift
//  Tracktify
//
//  Created by Christian Catenacci on 08/08/24.
//

import SwiftUI

struct SuggestView: View {
    var body: some View {
        HStack{
            Spacer()
            Text("single song")
                .padding()
                .background(.accent.opacity(0.5))
                .clipShape(RoundedRectangle(cornerRadius: 10))
            Spacer()
            NavigationLink {
                GenresView()
                    .background(.cBlack)
            } label: {
                Text("suggest a playlist")
                    .foregroundStyle(.black)
                    .padding()
                    .background(.accent)
                    .clipShape(RoundedRectangle(cornerRadius: 10))

            }
            

            
            Spacer()
        }
        
    }
}

#Preview {
    SuggestView()
}
