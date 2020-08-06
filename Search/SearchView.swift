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
        VStack(alignment: .leading) {
            MainHeader(titleString: "Search For Songs", settingsView: EmptyView(), infoView: EmptyView())
            self.searchBox
            self.results
        }
        .frame(maxHeight: .infinity, alignment: .top)
        .background(Color("SpotifyBlack")
            .edgesIgnoringSafeArea(.all))
    }
}

private extension SearchView {
    var searchBox: some View {
        HStack{
            Image(systemName: "magnifyingglass")
            ColorTextField(
                placeholder: Text("Search").foregroundColor(Color("SpotifyWhite")),
                text: $text,
                onCommit: {
                    do {
                        self.data = try SpotiFriend.search(query: self.text)
                    } catch {
                        print(error)
                    }
                }
            )
        }
        .style(SimpleTFStyle())
    }
    
    var results: some View {
        data.map { data in
            ScrollView() {
                VStack(alignment: .leading) {
                    ForEach(data.tracks.items, id: \.self.id) {
                        SearchItemView(track: $0, stack: self.stack)
                    }
                }
            }
        }
    }
}
