//
//  Page.swift
//  Playlists
//
//  Created by Nalin Gaddis on 8/7/20.
//  Copyright © 2020 Nalin Gaddis. All rights reserved.
//

import SwiftUI

struct Screen<HeaderType: Header, Content: View> : View {
    
    let header: HeaderType
    let content: () -> Content
    
    init(_ header: HeaderType, @ViewBuilder content: @escaping () -> Content) {
        self.header = header
        self.content = content
    }
    
    var body: some View {
        VStack {
            self.header
            VStack {
                self.content()
            }
            .frame(maxHeight: .infinity)
        }
        .style(NoHeaderNavStyle())
        .background(Color("SpotifyBlack")
            .edgesIgnoringSafeArea(.all))
    }
}

