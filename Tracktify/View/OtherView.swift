//
//  OtherView.swift
//  Tracktify
//
//  Created by Christian Catenacci on 08/08/24.
//

import SwiftUI

struct OtherView: View {
    @EnvironmentObject var spotifyDataManager: SpotifyDataManager
    
    var body: some View {
        Text("logout")
            .foregroundStyle(.white)
            .padding(.vertical, 8)
            .padding(.horizontal, 12)
            .background(.red)
            .clipShape(RoundedRectangle(cornerRadius: 14))
            .onTapGesture {
                spotifyDataManager.logout()
            }
    }
}

#Preview {
    OtherView()
}
