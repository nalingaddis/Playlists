//
//  StackItemView.swift
//  Playlists
//
//  Created by Nalin Gaddis on 7/22/20.
//  Copyright © 2020 Nalin Gaddis. All rights reserved.
//

import Foundation
import SwiftUI

struct StackItemView: View {
    @State var offset = CGFloat.zero
    
    let track: Track
    let stack: Stack
    
    var body: some View {
        track
            .offset(x: offset, y: 0)
            .gesture(DragGesture()
                .onChanged { value in
                    if value.translation.width < 0, value.translation.width > -75 {
                        self.offset = value.translation.width
                    }
                }
                .onEnded { _ in
                    if self.offset != 0 {
                        self.offset = 0
                        self.stack.remove(track: self.track)
                    }
                }
            )
    }
}
