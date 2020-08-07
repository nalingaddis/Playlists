//
//  Header.swift
//  Playlists
//
//  Created by Nalin Gaddis on 8/4/20.
//  Copyright © 2020 Nalin Gaddis. All rights reserved.
//

import SwiftUI

protocol Header: View {
    associatedtype LeftView: View
    associatedtype RightView: View
    
    var title: String { get }
    var left: LeftView { get }
    var right: RightView { get }
}

extension Header {
    var body: some View {
        HStack {
            left
            titleText
            right
        }
    }
    
    var titleText: some View {
        Text(title)
        .style(TitleStyle())
    }
}

struct MainHeader<InfoView: View>: Header {
    var title: String
    var infoView: InfoView
    
    var left: some View {
        NavigationLink(destination: SettingsView()){
            Image(systemName: "gear")
            .style(IconButtonStyle())
        }
    }
    
    var right: some View {
        NavigationLink(destination: infoView) {
            Image(systemName: "questionmark")
            .style(IconButtonStyle())
        }
    }
}

struct NavHeader<RightButton: View> : Header {
    @Environment(\.presentationMode) var presentationMode
    
    var title: String
    var right: RightButton
    
    init(_ title: String, right: RightButton) {
        self.title = title
        self.right = right
    }
    
    var left: some View {
        Button(action: { self.presentationMode.wrappedValue.dismiss() }) {
            Image(systemName: "chevron.left")
            .style(IconButtonStyle())
        }
    }
}

func SimpleNavHeader(_ title: String) -> some Header {
    NavHeader(
        title,
        right:
            Image(systemName: "chevron.right")
            .padding()
            .foregroundColor(Color("SpotifyBlack")
        )
    )
}
