//
//  SearchView.swift
//  Playlists
//
//  Created by Nalin Gaddis on 7/20/20.
//  Copyright © 2020 Nalin Gaddis. All rights reserved.
//

import SwiftUI

struct SearchView: View {
    @EnvironmentObject var stack: Stack
    
    @State var text: String = ""
    @State var data: Search?
    
    var body: some View {
        VStack {
            searchBox
            results
        }
    }
}

private extension SearchView {
    var searchBox: some View {
        TextField("Search songs...", text: $text,
            onCommit: {
                do {
                    self.data = try SpotiFriend.search(query: self.text)
                } catch {
                    print(error)
                }
            }
        )
    }
    
    var results: some View {
        guard let data = data else {
            return AnyView(EmptyView())
        }
        
        return AnyView(
            ScrollView {
                VStack {
                    ForEach(data.tracks.items, id: \.self.id) { SearchItemView(track: $0, stack: self.stack) }
                }
            }
        )
    }
}
