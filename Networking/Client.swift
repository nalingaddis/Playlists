//
//  Client.swift
//  Playlists
//
//  Created by Nalin Gaddis on 7/14/20.
//  Copyright © 2020 Nalin Gaddis. All rights reserved.
//

import Foundation
import Combine

enum ClientError: Error {
    /// Unable to generate a valid URLRequest
    case invalidURL
    /// The response of the object threw an  `error`
    case malformedResponse(Error)
    /// The call's response was not HTTP
    case nonHTTPResponse
    /// An `error` occured while trying to send the request
    case networkError(Error)
}

struct Client {
    let dataTasker = URLSession.shared
    
    /// Sends a request with a provided completion handler
    /// - Parameters:
    ///   - request: The request to send
    ///   - completion: The closure to execute upon success/failure
    func send<R: Request>(_ request: R, completion: @escaping (Result<R.ResponseType, ClientError>) -> Void) {
        guard let url = request.buildURLRequest() else {
            return completion(.failure(.invalidURL))
        }
            
        let task = dataTasker.dataTask(with: url) { data, response, error in
            if let error = error {
                return completion(.failure(.networkError(error)))
            }
            
            guard let response = response as? HTTPURLResponse else {
                return completion(.failure(.nonHTTPResponse))
            }
            
            do {
                let output = try R.ResponseType(input: data, response: response)
                return completion(.success(output))
            } catch {
                return completion(.failure(.malformedResponse(error)))
            }
        }
        
        task.resume()
    }
}

extension Client {
    
    /// Send the request and return a publisher for the response
    /// - Parameter request: The request to send
    /// - Returns: A publisher the will turn a response object on success or an error on failure
    func send<R: Request>(_ request: R) -> AnyPublisher<R.ResponseType, ClientError> {
        return Future { completion in
            self.send(request) { result in
                switch result {
                case .success(let response):
                    return completion(.success(response))
                case .failure(let error):
                    return completion(.failure(error))
                }
            }
        }.eraseToAnyPublisher()
    }
}
