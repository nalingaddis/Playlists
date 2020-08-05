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
                    .padding()
                    .frame(maxWidth: .infinity)
                    .foregroundColor(Color("SpotifyWhite"))
                    .font(.title)
                    .cornerRadius(2)
                
                stackView
                
                HStack {
                    save
                    clear
                }
                .disabled(self.stack.tracks.isEmpty)
                .padding()
            }
            .frame(maxWidth: .infinity)
            .background(Color("SpotifyBlack")
                .edgesIgnoringSafeArea(.all))
            .navigationBarHidden(true)
            .navigationBarTitle("Playlist Preview")
        }
    }
    
    private var save: some View {
        NavigationLink(destination: SaveView().environmentObject(stack)) {
            Text("Save")
            .padding()
            .frame(maxWidth: .infinity)
            .foregroundColor(Color("SpotifyWhite"))
            .background(Color("SpotifyGreen"))
            .cornerRadius(40)
        }
    }
    
    private var clear: some View {
        Button(action: {
            self.stack.clear()
        }) {
            Text("Clear")
            .padding()
            .frame(maxWidth: .infinity)
            .foregroundColor(Color("SpotifyWhite"))
            .background(Color("SpotifyGreen"))
            .cornerRadius(40)
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
