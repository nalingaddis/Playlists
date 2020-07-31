//
//  ContentView.swift
//  Playlists
//
//  Created by Nalin Gaddis on 7/14/20.
//  Copyright © 2020 Nalin Gaddis. All rights reserved.
//

import SwiftUI
import Combine

struct LoginView: View {
    var body: some View {
        Button(action: {
            Authenticator.login()
        }) {
            Text("Login to Spotify")
        }
    }
}
