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
    
    var playlists = [Playlist]()
    
    init() {
        do {
            let me = try SpotiFriend.whoami()
            try SpotiFriend.playlists()?.forEach { page in
                page.items.forEach { playlist in
                    if playlist.owner == me {
                        self.playlists.append(playlist)
                    }
                }
            }
        } catch {
            print(error)
        }
    }
    
    var body: some View {
        ScrollView {
            ForEach(playlists, id: \.self) { playlist in
                Button(action: {
                    do { try SpotiFriend.add(self.stack.tracks, to: playlist) }
                    catch { print(error) }
                }) {
                    Text(playlist.name)
                }
            }
        }
    }
}
