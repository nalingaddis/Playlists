//
//  Login.swift
//  Playlists
//
//  Created by Nalin Gaddis on 7/15/20.
//  Copyright © 2020 Nalin Gaddis. All rights reserved.
//

import Foundation

/// Request for user login
enum LoginURI {
    static let path = "https://accounts.spotify.com/authorize"
    static let redirectURI = "Playlists://callback"
     
    static func buildRUI(_ challenge: String) -> URL? {
        let parameters = [
            "client_id": "73513868bd4e4730b2246b6961d0b592",
            "response_type": "code",
            "redirect_uri": redirectURI,
            "scope": "playlist-modify-public playlist-modify-private",
            "code_challenge_method": "S256",
            "code_challenge": challenge
        ]
        
        var components = URLComponents(string: "https://accounts.spotify.com/authorize")!
        
        var queries = [URLQueryItem]()
        parameters.forEach { key, value in
            queries.append(URLQueryItem(name: key, value: value))
        }
        components.queryItems = queries
        
        return components.url
    }
}
