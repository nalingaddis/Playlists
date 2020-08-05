//
//  CreatePlaylistView.swift
//  Playlists
//
//  Created by Nalin Gaddis on 8/1/20.
//  Copyright © 2020 Nalin Gaddis. All rights reserved.
//

import SwiftUI

struct CreatePlaylistView: View {
    @Environment(\.presentationMode) var presentation
    
    @EnvironmentObject var stack: Stack
    
    @State var name = ""
    @State var description = String("")
    @State var isPrivate = false
    @State var alertShowing = false
    
    init() {
        UISwitch.appearance().onTintColor = UIColor(named: "SpotifyGreen")
    }
    
    var body: some View {
        VStack{
            HStack {
                Button(action: { self.presentation.wrappedValue.dismiss() }) {
                    Image(systemName: "chevron.left")
                }
                .padding()
                .foregroundColor(Color("SpotifyWhite"))
                
                Text("New Playlist")
                .padding()
                .frame(maxWidth: .infinity)
                .foregroundColor(Color("SpotifyWhite"))
                .font(.title)
                .cornerRadius(2)
            }
            
            ColorTextField(
                placeholder: Text("Name").foregroundColor(Color("SpotifyWhite")),
                text: $name)
                .padding()
                .foregroundColor(Color("SpotifyWhite"))
                .background(Color.gray)
            
            ColorTextField(
                placeholder: Text("Description").foregroundColor(Color("SpotifyWhite")),
                text: $description)
                .padding()
                .frame(maxHeight: .infinity)
                .foregroundColor(Color("SpotifyWhite"))
                .background(Color.gray)
                
            Toggle(isOn: $isPrivate) {
                Text("Make private")
                .padding()
                .foregroundColor(Color("SpotifyWhite"))
            }.padding()
            
            Button(action: {
                do {
                    let playlist = try SpotiFriend.createPlaylist(name: self.name, description: self.description, isPrivate: self.isPrivate)
                    try SpotiFriend.add(self.stack.tracks, to: playlist)
                } catch {
                    print(error)
                }
                self.presentation.wrappedValue.dismiss()
                self.alertShowing = true
            }) {
                Text("Create and Add")
                .padding()
                .frame(maxWidth: .infinity)
                .foregroundColor(Color("SpotifyWhite"))
                .background(Color("SpotifyGreen"))
                .cornerRadius(40)
            }
            .padding()
            .disabled(name.isEmpty)
        }
        .frame(maxHeight: .infinity)
        .navigationBarHidden(true)
        .navigationBarTitle("Create A Playlist")
        .background(Color("SpotifyBlack").edgesIgnoringSafeArea(.all))
        .alert(isPresented: $alertShowing) {
            Alert(title: Text("Songs added successfully"))
        }
    }
}
