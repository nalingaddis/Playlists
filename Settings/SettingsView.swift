//
//  SettingsView.swift
//  Playlists
//
//  Created by Nalin Gaddis on 8/4/20.
//  Copyright © 2020 Nalin Gaddis. All rights reserved.
//

import SwiftUI

struct SettingsView: View {
    var body: some View {
        Screen(SimpleNavHeader("Settings")) {
            self.signoutButton
        }
    }

    @State var action: Int? = 0
    var signoutButton: some View {
        VStack {
            NavigationLink(destination: LoginView(), tag: 1, selection: $action) {
                EmptyView()
            }
            
            Text("Sign Out")
            .style(SimpleButtonStyle())
            .onTapGesture {
                do {
                    try Authenticator.logout()
                    self.action = 1
                } catch {
                    print(error)
                }
            }
        }
        
    }
}
