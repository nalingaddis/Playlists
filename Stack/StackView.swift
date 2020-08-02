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
            VStack{
                HStack {
                    NavigationLink(destination: SaveView().environmentObject(stack)) {
                        Text("Save")
                    }
                    Button(action: {
                        self.stack.clear()
                    }) {
                        Text("Clear")
                    }
                }.disabled(self.stack.tracks.isEmpty)
                ScrollView {
                    VStack {
                        ForEach(stack.tracks, id: \.self.id) { StackItemView(track: $0, stack: self.stack) }
                    }
                }
            }
        }
    }
}
