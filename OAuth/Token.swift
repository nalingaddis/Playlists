//
//  Tokens.swift
//  Playlists
//
//  Created by Nalin Gaddis on 7/15/20.
//  Copyright © 2020 Nalin Gaddis. All rights reserved.
//

import Foundation

enum TokenError: Error {
    /// Failed to find the `redirect_uri` from the login request
    case missingRedirectURI
    /// Failed to convert the client id/secret into data
    case clientData
    /// A status code other than `200` was returned
    case statusCode(Int)
    /// The response does not contain data
    case missingData
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

/// Model for token response data
struct Token: Decodable {
    let access_token: String
    let token_type: String
    let scope: String
    let expires_in: Int
    let refresh_token: String
}
