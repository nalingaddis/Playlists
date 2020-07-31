//
//  Login.swift
//  Playlists
//
//  Created by Nalin Gaddis on 7/15/20.
//  Copyright © 2020 Nalin Gaddis. All rights reserved.
//

import Foundation

enum LoginError: Error {
    /// Status code other than `200` was returned
    case statusCode(Int)
    /// The response does not contain a redirect URL
    case missingRedirectURL
}

/// Request for user login
struct LoginRequest: Request {
    typealias ResponseType = LoginResponse
        
    var path: String = "https://accounts.spotify.com/authorize/"
    var method: HTTPMethod = HTTPMethod.GET
    var contentType: ContentType = .urlencoded
    var headers: [String : String]? = nil
    var parameters: [String : Any]? = [
        "client_id": "73513868bd4e4730b2246b6961d0b592",
        "response_type": "code",
        "redirect_uri": "Playlists://callback",
        "scope": "playlist-modify-public playlist-modify-private"
    ]
}

/// Response from user login
struct LoginResponse: Response {
    var data: URL
    
    init(input: Data?, response: HTTPURLResponse) throws {
        guard response.statusCode == 200 else {
            throw LoginError.statusCode(response.statusCode)
        }
        
        guard let url = response.url else {
            throw LoginError.missingRedirectURL
        }
        
        self.data = url
    }
}
