//
//  Playlist.swift
//  Playlists
//
//  Created by Nalin Gaddis on 7/27/20.
//  Copyright © 2020 Nalin Gaddis. All rights reserved.
//

import Foundation
import SwiftUI

struct Playlist: Pagable {
    let name: String
    let owner: User
    let id: String
    
    var body: some View {
        Text(self.name)
    }
}
