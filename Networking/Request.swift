//
//  Request.swift
//  Playlists
//
//  Created by Nalin Gaddis on 7/14/20.
//  Copyright © 2020 Nalin Gaddis. All rights reserved.
//

import Foundation

enum HTTPMethod: String {
    case GET
    case POST
}

enum ContentType: String {
    case urlencoded = "application/x-www-form-urlencoded"
    case json = "application/json"
}

protocol Request {
    associatedtype ResponseType: Response
    
    var path: String { get }
    var method: HTTPMethod { get }
    var contentType: ContentType { get }
    var headers: [String: String]? { get }
    var parameters: [String: Any]? { get }
}

extension Request {
    
    /// Returns the URLRequest form of an object
    /// - Returns: A URLRequest representing the Request object
    func buildURLRequest() -> URLRequest? {
        guard var components = URLComponents(string: path) else { return nil }
        
        if let params = parameters, contentType == .urlencoded {
            var queries = [URLQueryItem]()
            params.forEach { key, value in
                queries.append(URLQueryItem(name: key, value: value as? String))
            }
            components.queryItems = queries
        }
        
        guard let url = components.url else { return nil }
        
        var request = URLRequest(url: url)
        request.httpMethod = method.rawValue
        
        if let headers = headers {
            request.allHTTPHeaderFields = headers
        }
        request.addValue(contentType.rawValue, forHTTPHeaderField: "Content-Type")
        
        if method == .POST {
            if contentType == .json {
                do { request.httpBody = try JSONSerialization.data(withJSONObject: parameters as Any) }
                catch { return nil }
            }
            if contentType == .urlencoded {
                request.httpBody = components.query?.data(using: .utf8)
            }
        }
                
        return request
    }
}
