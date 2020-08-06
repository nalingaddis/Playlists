//
//  Refresh.swift
//  Playlists
//
//  Created by Nalin Gaddis on 8/5/20.
//  Copyright © 2020 Nalin Gaddis. All rights reserved.
//

import Foundation

struct RefreshRequest: Request {
    typealias ResponseType = DecodableResponse<RefreshedToken>
    
    private let
        clientId = "73513868bd4e4730b2246b6961d0b592",
        clientSecret = "b2c33f66bf444d50884daa41be3a13b6"
    
    var path: String = "https://accounts.spotify.com/api/token"
    var method: HTTPMethod = HTTPMethod.POST
    var contentType: ContentType = .urlencoded
    var headers: [String : String]?
    var parameters: [String : Any]?
    
    init(_ refreshToken: String) {
        parameters = [
            "grant_type": "refresh_token",
            "refresh_token": refreshToken
        ]
        
        guard let clientData = String(clientId+":"+clientSecret).data(using: .utf8)?.base64EncodedString() else {
            fatalError()
        }
        
        headers = [
            "Authorization": "Basic \(clientData)"
        ]
    }
    
}

struct RefreshedToken: Decodable {
    let access_token: String
    let token_type: String
    let scope: String
    let expires_in: Int
}
