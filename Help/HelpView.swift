//
//  InstructionsView.swift
//  Playlists
//
//  Created by Nalin Gaddis on 8/7/20.
//  Copyright © 2020 Nalin Gaddis. All rights reserved.
//

import SwiftUI

struct HelpView: View {
    var body: some View {
        Screen(SimpleNavHeader("Help")) {
            self.searchHelp
            self.playlistHelp
        }
    }
}

extension HelpView {
    var searchHelp: some View {
        VStack {
            searchHeader
            searchBody
        }
    .foregroundColor(Color("SpotifyWhite"))
    }
    
    var searchHeader: some View {
        HStack {
            Image(systemName: "magnifyingglass")
            
            Text("Search")
        }
        .font(.title)
    }
    
    var searchBody: some View {
        Text("Search for songs using the search bar, then swipe right on the songs name to add it to your Playlist Preview.")
        .fixedSize(horizontal: false, vertical: true)
        .padding()
    }
}

extension HelpView {
    var playlistHelp: some View {
        VStack {
            playlistHeader
            playlistBody
        }
        .foregroundColor(Color("SpotifyWhite"))
    }
    
    var playlistHeader: some View {
        HStack {
            Image(systemName: "music.note.list")
            
            Text("Preview")
        }
        .font(.title)
    }
    
    var playlistBody: some View {
        Text("This preview shows you the songs you've added to your temporary playlist. Press Save to add these songs to an existing playlist or to save them as a new playlist. Press Clear to restart your build.")
        .fixedSize(horizontal: false, vertical: true)
        .padding()
    }
}

struct HelpPreviews: PreviewProvider {
    static var previews: some View {
        HelpView()
    }
}
