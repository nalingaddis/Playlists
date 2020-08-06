//
//  TextField.swift
//  Playlists
//
//  Created by Nalin Gaddis on 8/3/20.
//  Copyright © 2020 Nalin Gaddis. All rights reserved.
//

import SwiftUI

struct ColorTextField: View {
    var placeholder: Text
    @Binding var text: String
    var onEditingChanged: (Bool)->() = { _ in }
    var onCommit: ()->() = { }
    
    var body: some View {
        ZStack(alignment: .leading) {
            if text.isEmpty { placeholder }
            TextField("", text: $text, onEditingChanged: onEditingChanged, onCommit: onCommit)
        }
    }
}
