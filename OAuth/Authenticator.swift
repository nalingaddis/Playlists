//
//  Login.swift
//  Playlists
//
//  Created by Nalin Gaddis on 7/15/20.
//  Copyright © 2020 Nalin Gaddis. All rights reserved.
//

import Dispatch
import Foundation

enum AuthenticatorError: Error {
    /// The login callback is missing the code parameter
    case missingCode
    /// Failed to create a token request
    case requestCreation
}

struct Authenticator {
    private static let client = Client()
    
    /// Prompts a user login request to begin the authentication process
    static func login() {
        client.send(LoginRequest()) { result in
            switch result {
            case .success(let response):
                DispatchQueue.main.async {
                    UIApplication.shared.open(response.data)
                }
            case .failure(let clientError):
                print(clientError)
            }
        }
    }
    
    /// Requests access tokens using the callback URL from the user login
    /// - Parameter callback: The callback URL sent after Spotify login
    /// - Throws: `AuthenticationError`
    static func tokens(using callback: URL, lock: Semaphore) throws {
        guard let code =
            URLComponents(url: callback, resolvingAgainstBaseURL: true)?
                .queryItems?
                    .first(where: { $0.name == "code" })?
                        .value
        else {
            throw AuthenticatorError.missingCode
        }
        
        do {
            client.send(try TokenRequest(code)) { result in
                switch result {
                case .success(let response):
                    let token = response.data
                    do {
                        try Keychain.store(token.access_token, forKey: "playlists.spotify.access_token")
                        try Keychain.store(token.refresh_token, forKey: "playlists.spotify.refresh_token")
                    } catch {
                        print(error)
                    }
                case .failure(let clientError):
                    print(clientError)
                }
                lock.signal()
            }
        } catch {
            throw AuthenticatorError.requestCreation
        }
    }
}
