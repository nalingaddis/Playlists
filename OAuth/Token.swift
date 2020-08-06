//
//  Tokens.swift
//  Playlists
//
//  Created by Nalin Gaddis on 7/15/20.
//  Copyright © 2020 Nalin Gaddis. All rights reserved.
//

import Foundation

/// Model for token response data
struct Token: Decodable {
    let access_token: String
    let token_type: String
    let scope: String
    let expires_in: Int
    let refresh_token: String
}

/// Request for access and refresh tokens
struct TokenRequest: Request {
    typealias ResponseType = DecodableResponse<Token>
    
    var path: String = "https://accounts.spotify.com/api/token"
    var method: HTTPMethod = HTTPMethod.POST
    var contentType: ContentType = .urlencoded
    var headers: [String : String]?
    var parameters: [String : Any]?
    
    init(code: String, verfier: String) {
        parameters = [
            "client_id": Authenticator.clientID,
            "grant_type": "authorization_code",
            "code": code,
            "redirect_uri": LoginURI.redirectURI,
            "code_verifier": verfier
        ]
    }
}

struct RefreshRequest: Request {
    typealias ResponseType = DecodableResponse<Token>
    
    var path: String = "https://accounts.spotify.com/api/token"
    var method: HTTPMethod = HTTPMethod.POST
    var contentType: ContentType = .urlencoded
    var headers: [String : String]?
    var parameters: [String : Any]?
    
    init(_ refreshToken: String) {
        parameters = [
            "grant_type": "refresh_token",
            "refresh_token": refreshToken,
            "client_id": Authenticator.clientID
        ]
    }
}
