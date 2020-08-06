//
//  NavigationViewStyles.swift
//  Playlists
//
//  Created by Nalin Gaddis on 8/4/20.
//  Copyright © 2020 Nalin Gaddis. All rights reserved.
//

import SwiftUI

struct NoHeaderNavStyle: ViewModifier {
    func body(content: Content) -> some View {
        content
            .frame(maxWidth: .infinity)
            .background(Color("SpotifyBlack").edgesIgnoringSafeArea(.all))
            .navigationBarHidden(true)
            .navigationBarTitle("No Header")
    }
}
