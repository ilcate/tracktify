//
//  Title.swift
//  Tracktify
//
//  Created by Christian Catenacci on 19/08/24.
//

import SwiftUI

struct Title: View {
    let titleText : String
    let toExecute : () -> Void
    
    var body: some View {
        
        Text(titleText)
            .normalTextStyle(fontName: "LeagueSpartan-SemiBold", fontSize: 24, fontColor: .white)
            .onAppear{
                toExecute()
            }.padding(.horizontal, 12)
    }
}

