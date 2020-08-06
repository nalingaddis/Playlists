//
//  Login.swift
//  Playlists
//
//  Created by Nalin Gaddis on 7/15/20.
//  Copyright © 2020 Nalin Gaddis. All rights reserved.
//

import Combine
import Dispatch
import Foundation

enum AuthenticatorError: Error {
    /// The login callback is missing the code parameter
    case missingCode
    /// Failed to create a token request
    case requestCreation
}

enum Authenticator {
    static let clientID = "73513868bd4e4730b2246b6961d0b592"

    private static let client = Client()
    private static let codeGenerator = CodeGenerator()
    
    static func login() {
        DispatchQueue.main.async {
            guard let url = LoginURI.buildRUI(codeGenerator.challenge) else {
                print("Something went wrong")
                return
            }
            
            UIApplication.shared.open(url)
        }
    }
    
    static func tokens(using code: String) throws {
        let lock = Semaphore()
        
        client.send(TokenRequest(code: code, verfier: codeGenerator.verifier)) { result in
            switch result {
            case .success(let response):
                store(response.data)
            case .failure(let clientError):
                print(clientError)
            }
            lock.signal()
        }
        lock.wait()
    }
    
    static func refresh(_ token: String) throws {
        let lock = Semaphore()
        
        client.send(RefreshRequest(token)) { result in
            switch result {
            case .success(let response):
                store(response.data)
            case .failure(let clientError):
                print(clientError)
            }
            lock.signal()
        }
        lock.wait()
    }
    
    private static func store( _ token: Token) {
        do {
            try Keychain.store(token.access_token, forKey: "playlists.spotify.access_token")
            try Keychain.store(token.refresh_token, forKey: "playlists.spotify.refresh_token")
        } catch {
            print(error)
        }
    }
}
