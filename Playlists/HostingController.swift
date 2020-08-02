//
//  HostingController.swift
//  Playlists
//
//  Created by Nalin Gaddis on 8/2/20.
//  Copyright © 2020 Nalin Gaddis. All rights reserved.
//

import SwiftUI

class HostingController<Content>: UIHostingController<Content> where Content: View {
    override var preferredStatusBarStyle: UIStatusBarStyle {
        .lightContent
    }
}
