//
//  Button.swift
//  Playlists
//
//  Created by Nalin Gaddis on 8/2/20.
//  Copyright © 2020 Nalin Gaddis. All rights reserved.
//

import SwiftUI

struct SimpleButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .padding()
            .cornerRadius(40)
            .foregroundColor(.white)
            .background(Color("SpotifyGreen"))
    }
}
