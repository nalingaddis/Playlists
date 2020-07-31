//
//  Semaphore.swift
//  Playlists
//
//  Created by Nalin Gaddis on 7/21/20.
//  Copyright © 2020 Nalin Gaddis. All rights reserved.
//

import Foundation

struct Semaphore {
    let semaphore = DispatchSemaphore(value: 0)
    
    func wait() {
        semaphore.wait()
    }
    
    func signal() {
        semaphore.signal()
    }
}
