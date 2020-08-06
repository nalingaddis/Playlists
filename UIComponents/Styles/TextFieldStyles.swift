//
//  TextFieldStyles.swift
//  Playlists
//
//  Created by Nalin Gaddis on 8/4/20.
//  Copyright © 2020 Nalin Gaddis. All rights reserved.
//

import SwiftUI

struct SimpleTFStyle: ViewModifier {
    func body(content: Content) -> some View {
        content
            .padding()
            .background(Color.gray)
            .foregroundColor(Color("SpotifyWhite"))
            .multilineTextAlignment(.leading)
            .cornerRadius(2)
    }
}
