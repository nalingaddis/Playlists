//
//  Stack.swift
//  Playlists
//
//  Created by Nalin Gaddis on 7/22/20.
//  Copyright © 2020 Nalin Gaddis. All rights reserved.
//

import Foundation
import SwiftUI

class Stack: ObservableObject {
    /// A list of tracks on the current stack
    @Published var tracks = [Track]()
    
    /// Add a track to the stack
    /// - Parameter track: The track to add
    func add(track: Track) {
        if tracks.reduce(true, { $0 && $1.id != track.id}) {
            tracks.append(track)
        }
    }
    
    /// Remove a track from the stack
    /// - Parameter track: The track to remove
    func remove(track: Track) {
        tracks.removeAll(where: { $0.id == track.id })
    }
    
    func clear() {
        tracks.removeAll()
    }
}
