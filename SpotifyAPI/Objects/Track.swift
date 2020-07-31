//
//  Track.swift
//  Playlists
//
//  Created by Nalin Gaddis on 7/21/20.
//  Copyright © 2020 Nalin Gaddis. All rights reserved.
//

import Foundation
import SwiftUI

struct Track: Pagable {
    let album: Album
    let artists: [Artist]
    let name: String
    let id: String
    let uri: String
    
    var body: some View {
        VStack {
            Text(self.name)
            Text(self.album.name)
            Text(self.artists.reduce(self.artists.first?.name ?? "") { $0+", "+$1.name })
        }
    }
}
