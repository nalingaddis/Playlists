//
//  Pager.swift
//  Playlists
//
//  Created by Nalin Gaddis on 7/21/20.
//  Copyright © 2020 Nalin Gaddis. All rights reserved.
//

import Foundation
import SwiftUI

typealias Pagable = Decodable & View & Hashable

struct Page<T: Pagable>: Pagable {
    let items: [T]
    let next: String?
    let previous: String?
    
    func nextRequest(token: String) -> SpotifyRequest<Page<T>>? {
        guard let url = next else { return nil }
        
        let endpoint = url.replacingOccurrences(of: SpotifyAPIBasePath, with: "")
        
        return SpotifyRequest<Page<T>>(
            endpoint: endpoint,
            method: .GET,
            token: token
        )
    }
    
    var body: some View {
        VStack {
            ForEach(self.items, id: \.self) { $0 }
        }
    }
}
