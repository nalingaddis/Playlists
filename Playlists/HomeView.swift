//
//  HomeView.swift
//  Playlists
//
//  Created by Nalin Gaddis on 7/22/20.
//  Copyright © 2020 Nalin Gaddis. All rights reserved.
//

import SwiftUI

struct HomeView: View {
    let searchView: AnyView
    let stackView: AnyView
        
    init() {
        let stack = Stack()
        searchView = AnyView(SearchView().environmentObject(stack))
        stackView = AnyView(StackView().environmentObject(stack))
        
        UITabBar.appearance().barTintColor = UIColor(named: "SpotifyBlack")
    }
    
    var body: some View {
        TabView {
            searchView
                .tabItem({ Image(systemName: "magnifyingglass") })
            stackView
                .tabItem({ Image(systemName: "music.note.list") })
        }
    }
}

struct HomePreviews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
