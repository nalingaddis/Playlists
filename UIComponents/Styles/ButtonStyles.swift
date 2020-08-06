//
//  Button.swift
//  Playlists
//
//  Created by Nalin Gaddis on 8/2/20.
//  Copyright © 2020 Nalin Gaddis. All rights reserved.
//

import SwiftUI

struct SimpleButtonStyle: ViewModifier {
    func body(content: Content) -> some View {
        content
            .padding()
            .frame(maxWidth: .infinity)
            .foregroundColor(Color("SpotifyWhite"))
            .background(Color("SpotifyGreen"))
            .cornerRadius(40)
    }
}

struct IconButtonStyle: ViewModifier {
    func body(content: Content) -> some View {
        content
            .padding()
            .foregroundColor(Color("SpotifyWhite"))
    }
}
