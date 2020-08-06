//
//  Challenge.swift
//  Playlists
//
//  Created by Nalin Gaddis on 8/5/20.
//  Copyright © 2020 Nalin Gaddis. All rights reserved.
//

import Foundation

struct CodeGenerator {
    let verifier: String
    let challenge: String
    
    init() {
        self.verifier = String.random(100)
        self.challenge = verifier.data(using: .utf8)!.sha256.base64EncodedString()
            .replacingOccurrences(of: "/", with: "_")
            .replacingOccurrences(of: "+", with: "-")
            .replacingOccurrences(of: "=", with: "")
    }
}

extension CodeGenerator {
    enum Errors: Error {
        case dataConversionError(String)
    }
}

extension String {
    static func random(_ length: Int) -> String {
        let characters = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789_.-~"
        return String((0..<length).map { _ in characters.randomElement()! })
    }
}

extension Data {
    var sha256: Data {
       var hash = [UInt8](repeating: 0,  count: Int(CC_SHA256_DIGEST_LENGTH))
       self.withUnsafeBytes {
           _ = CC_SHA256($0.baseAddress, CC_LONG(self.count), &hash)
       }
       return Data(hash)
   }
}
