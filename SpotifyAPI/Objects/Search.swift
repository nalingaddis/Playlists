//
//  Search.swift
//  Playlists
//
//  Created by Nalin Gaddis on 7/27/20.
//  Copyright © 2020 Nalin Gaddis. All rights reserved.
//

import Foundation

struct Search: Decodable {
    let tracks: Page<Track>
}
