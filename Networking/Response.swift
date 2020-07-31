//
//  Response.swift
//  Playlists
//
//  Created by Nalin Gaddis on 7/15/20.
//  Copyright © 2020 Nalin Gaddis. All rights reserved.
//

import Foundation

/// Processes and stores a given HTTP response
protocol Response {
    associatedtype DataType
    var data: DataType { get set }
    init(input: Data?, response: HTTPURLResponse) throws
}

enum ResponseError: Error {
    case statusCode(Int)
    case missingData
}

struct DecodableResponse<T: Decodable>: Response {
    var data: T
    init(input: Data?, response: HTTPURLResponse) throws {
        guard response.statusCode / 100 == 2 else {
            throw ResponseError.statusCode(response.statusCode)
        }
        
        guard let input = input else {
            throw ResponseError.missingData
        }
        
        data = try JSONDecoder().decode(T.self, from: input)
    }
}
