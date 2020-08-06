//
//  Header.swift
//  Playlists
//
//  Created by Nalin Gaddis on 8/4/20.
//  Copyright © 2020 Nalin Gaddis. All rights reserved.
//

import SwiftUI

struct MainHeader<SettingsView: View, InfoView: View>: View {
    let titleString: String
    let settingsView: SettingsView
    let infoView: InfoView
    
    var body: some View {
        HStack {
            settingsButton
            title
            infoButton
        }
    }
    
    var settingsButton: some View {
        NavigationLink(destination: settingsView){
            Image(systemName: "gear")
            .style(IconButtonStyle())
        }
    }
    
    var title: some View {
        Text(titleString)
        .style(TitleStyle())
    }
    
    var infoButton: some View {
        NavigationLink(destination: infoView) {
            Image(systemName: "questionmark")
            .style(IconButtonStyle())
        }
    }
}
