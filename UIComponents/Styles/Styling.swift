//
//  Styling.swift
//  Playlists
//
//  Created by Nalin Gaddis on 8/4/20.
//  Copyright © 2020 Nalin Gaddis. All rights reserved.
//

import SwiftUI

extension View {
    func style<Style: ViewModifier>(_ style: Style) -> some View {
        ModifiedContent(content: self, modifier: style)
    }
}
