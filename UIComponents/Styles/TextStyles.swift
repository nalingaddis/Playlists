//
//  TextStyles.swift
//  Playlists
//
//  Created by Nalin Gaddis on 8/4/20.
//  Copyright © 2020 Nalin Gaddis. All rights reserved.
//

import SwiftUI

struct TitleStyle: ViewModifier {
    func body(content: Content) -> some View {
        content
            .padding()
            .frame(maxWidth: .infinity)
            .foregroundColor(Color("SpotifyWhite"))
            .font(.title)
    }
}
