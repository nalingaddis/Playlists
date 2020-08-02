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
    
    var body: some View {
        VStack{
            TextField("Name", text: $name)
            TextField("Description", text: $description)
            Toggle(isOn: $isPrivate) {
                Text("Make private")
            }
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
            }
            .disabled(name.isEmpty)
        }
        .alert(isPresented: $alertShowing) {
            Alert(title: Text("Songs added successfully"))
        }
    }
}
