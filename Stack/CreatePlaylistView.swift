//
//  CreatePlaylistView.swift
//  Playlists
//
//  Created by Nalin Gaddis on 8/1/20.
//  Copyright © 2020 Nalin Gaddis. All rights reserved.
//

import SwiftUI

struct CreatePlaylistView: View {
    @Environment(\.presentationMode) var presentationMode
    @EnvironmentObject var stack: Stack
    
    @State var name = ""
    @State var description = String("")
    @State var isPrivate = false
    @State var alertShowing = false
    
    init() {
        UISwitch.appearance().onTintColor = UIColor(named: "SpotifyGreen")
    }
    
    var body: some View {
        Screen(SimpleNavHeader("New Playlist")) {
            self.nameTextField
            self.descriptionTextField
            self.isPrivateToggle
            self.createButton
        }
        .alert(isPresented: $alertShowing) { successAlert }
    }
}

private extension CreatePlaylistView {
    var nameTextField: some View {
        ColorTextField(
        placeholder: Text("Name").foregroundColor(Color("SpotifyWhite")),
        text: $name)
        .style(SimpleTFStyle())
    }
    
    var descriptionTextField: some View {
        ColorTextField(
        placeholder: Text("Description").foregroundColor(Color("SpotifyWhite")),
        text: $description)
        .style(SimpleTFStyle())
    }
    
    var isPrivateToggle: some View {
        Toggle(isOn: $isPrivate) {
            Text("Make private")
            .padding()
            .foregroundColor(Color("SpotifyWhite"))
        }.padding()
    }
    
    var createButton: some View {
        Button(action: {
            do {
                let playlist = try SpotiFriend.createPlaylist(name: self.name, description: self.description, isPrivate: self.isPrivate)
                try SpotiFriend.add(self.stack.tracks, to: playlist)
            } catch {
                print(error)
            }
            self.presentationMode.wrappedValue.dismiss()
            self.alertShowing = true
        }) {
            Text("Create and Add")
            .style(SimpleButtonStyle())
        }
        .padding()
        .disabled(name.isEmpty)
    }
    
    var successAlert: Alert {
        Alert(title: Text("Songs added successfully"))
    }
}
