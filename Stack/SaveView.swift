//
//  SaveView.swift
//  Playlists
//
//  Created by Nalin Gaddis on 7/27/20.
//  Copyright © 2020 Nalin Gaddis. All rights reserved.
//

import SwiftUI

struct SaveView: View {
    @EnvironmentObject var stack: Stack
    @Environment(\.presentationMode) var presentation
    @State var alertShowing = false
    
    var playlists: [Playlist] {
        var playlists = [Playlist]()
        do {
            let me = try SpotiFriend.whoami()
            try SpotiFriend.playlists()?.forEach { page in
                page.items.forEach { playlist in
                    if playlist.owner == me {
                        playlists.append(playlist)
                    }
                }
            }
        } catch {
            print(error)
        }
        return playlists
    }
    
    var body: some View {
        VStack {
            HStack {
                backButton
                title
                addPlaylistButton
            }
            
            playlistsList
        }
        .style(NoHeaderNavStyle())
        .alert(isPresented: $alertShowing) {
            Alert(title: Text("Songs added successfully"))
        }
    }
    
    func add(to playlist: Playlist) {
        do {
            try SpotiFriend.add(self.stack.tracks, to: playlist)
            self.presentation.wrappedValue.dismiss()
            self.alertShowing = true
        }
        catch { print(error) }
    }
}

private extension SaveView {
    var backButton: some View {
        Button(action: { self.presentation.wrappedValue.dismiss() }) {
            Image(systemName: "chevron.left")
            .style(IconButtonStyle())
        }
    }
    
    var title: some View {
        Text("Select A Playlist")
        .style(TitleStyle())
    }
    
    var addPlaylistButton: some View {
        NavigationLink(destination: CreatePlaylistView()
            .environmentObject(self.stack)
            .onDisappear {
                self.presentation.wrappedValue.dismiss()
        }) {
             Image(systemName: "plus")
            .style(IconButtonStyle())
        }
    }
    
    var playlistsList: some View {
        ScrollView {
            VStack {
                ForEach(playlists, id: \.self) { playlist in
                    Button(action: { self.add(to: playlist) }) {
                        playlist
                    }
                }
            }
        }
    }
}
