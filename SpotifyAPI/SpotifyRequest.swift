//
//  SpotifyRequest.swift
//  Playlists
//
//  Created by Nalin Gaddis on 7/21/20.
//  Copyright © 2020 Nalin Gaddis. All rights reserved.
//

import Foundation

let SpotifyAPIBasePath = "https://api.spotify.com/v1/"
struct SpotifyRequest<T: Decodable>: Request {
    typealias ResponseType = DecodableResponse<T>
    
    var path: String
    var method: HTTPMethod
    var contentType: ContentType
    var headers: [String: String]?
    var parameters: [String: Any]?
    
    /// Create an API request using a decodable object
    /// - Parameters:
    ///   - endpoint: The spotify endpoint to hit
    ///   - method: The HTTPMethod to use
    ///   - token: A valid authorization token
    ///   - contentType: The content type of the request body
    ///   - headers: Headers to include besides `Authorization`
    ///   - parameters: Query or body parameters
    init(
        endpoint: String,
        method: HTTPMethod,
        token: String,
        contentType: ContentType = .urlencoded,
        headers: [String: String]? = nil,
        parameters: [String: Any]? = nil)
    {
        self.path = "\(SpotifyAPIBasePath)\(endpoint)"
        
        self.headers = headers ?? [:]
        self.headers?["Authorization"] = "Bearer \(token)"
        
        self.method = method
        self.parameters = parameters
        
        self.contentType = contentType
    }
}
