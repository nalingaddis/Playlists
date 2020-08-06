//
//  StackView.swift
//  Playlists
//
//  Created by Nalin Gaddis on 7/22/20.
//  Copyright © 2020 Nalin Gaddis. All rights reserved.
//

import Foundation
import SwiftUI

struct StackView: View {
    @EnvironmentObject var stack: Stack
    
    var body: some View {
        NavigationView {
            VStack {
                Text("Playlist Preview")
                .style(TitleStyle())
                
                stackView
                
                HStack {
                    save
                    clear
                }
                .disabled(self.stack.tracks.isEmpty)
                .padding()
            }
            .style(NoHeaderNavStyle())
        }
    }
    
    private var save: some View {
        NavigationLink(destination: SaveView().environmentObject(stack)) {
            Text("Save")
            .style(SimpleButtonStyle())
        }
    }
    
    private var clear: some View {
        Button(action: {
            self.stack.clear()
        }) {
            Text("Clear")
            .style(SimpleButtonStyle())
        }
    }
    
    private var stackView: some View {
        ScrollView {
            VStack {
                ForEach(stack.tracks, id: \.self.id) {
                    StackItemView(track: $0, stack: self.stack)
                }
            }
        }
    }
}
