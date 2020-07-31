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
    
    let
        clientId = "73513868bd4e4730b2246b6961d0b592",
        clientSecret = "b2c33f66bf444d50884daa41be3a13b6"
    
    var path: String = "https://accounts.spotify.com/api/token"
    var method: HTTPMethod = HTTPMethod.POST
    var contentType: ContentType = .urlencoded
    var headers: [String : String]?
    var parameters: [String : Any]?
    
    init(_ code: String) throws {
        guard let redirectURI = LoginRequest().parameters?["redirect_uri"] else {
            throw TokenError.missingRedirectURI
        }
        
        parameters = [
            "grant_type": "authorization_code",
            "code": code,
            "redirect_uri": redirectURI
        ]
        
        guard let clientData = String(clientId+":"+clientSecret).data(using: .utf8)?.base64EncodedString() else {
            throw TokenError.clientData
        }
        
        headers = [
            "Authorization": "Basic \(clientData)"
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
