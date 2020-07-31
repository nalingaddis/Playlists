//
//  SpotiFriend.swift
//  Playlists
//
//  Created by Nalin Gaddis on 7/27/20.
//  Copyright © 2020 Nalin Gaddis. All rights reserved.
//

import Combine
import Foundation

enum SpotiFriend {
    /// Preforms Spotify search given a query
    /// - Parameter query: A string for Spotify to query with
    /// - Returns: A search object representing the search results, `nil` if the search returns no results
    static func search(query: String) throws -> Search? {
        let token = try fetchToken()
        
        let request = SpotifyRequest<Search>(
            endpoint: "search",
            method: .GET,
            token: token,
            parameters: [
                "q": query,
                "type": "track"
            ])
        
        let lock = Semaphore()
        var results: Search?
        
        Client().send(request) { result in
            switch result {
            case .success(let response):
                results = response.data
                lock.signal()
            case .failure(let error):
                print(error)
            }
        }
        lock.wait()
        return results
    }
    
    /// Get all playlists followed by a User
    /// - Returns: A list of playlist page objects
    static func playlists() throws -> [Page<Playlist>]? {
        var result: [Page<Playlist>]?
        let lock = Semaphore()
        let token = try fetchToken()
        var subs = Set<AnyCancellable>()
        
        findme(token: token)
            .flatMap { user in playlists(user.id, token: token) }
            .sink(
                receiveCompletion: { completion in
                    if case let .failure(error) = completion {
                        print(error.localizedDescription)
                    }
                    lock.signal()
                }, receiveValue: { page in
                    result = paginate(page, token: token)
                }
            )
            .store(in: &subs)
        lock.wait()
        
        return result
    }
    
    /// Returns the current user's profile
    /// - Returns: A `User` object representing the current user
    static func whoami() throws -> User {
        if let me = me { return me }
        
        let token = try fetchToken()
        let lock = Semaphore()
        var subs = Set<AnyCancellable>()
        
        findme(token: token)
            .sink(
                receiveCompletion: { completion in
                    if case let .failure(error) = completion {
                        print(error.localizedDescription)
                    }
                    lock.signal()
                }, receiveValue: { user in
                    self.me = user
                }
            )
            .store(in: &subs)
        lock.wait()
        
        guard let me = me else { throw Errors.errorFindingMe }
        return me
    }
    /// Stores the current user the first time it is computed
    private static var me: User?
    
    /// Adds the given `tracks` to the provided `playlist`
    /// - Parameters:
    ///   - tracks: The tracks to add
    ///   - playlist: The playlist to add to
    static func add(_ tracks: [Track], to playlist: Playlist) throws {
        let token = try fetchToken()
        let lock = Semaphore()
        
        stride(from: 0, to: tracks.count, by: 100)
            .map { Array(tracks[$0 ..< min($0+100, tracks.count)])}
            .forEach { tracks in
                let uris = tracks.map { $0.uri }
                
                let request = SpotifyRequest<Snapshot>(
                    endpoint: "playlists/\(playlist.id)/tracks",
                    method: .POST,
                    token: token,
                    contentType: .json,
                    parameters: ["uris": uris]
                )
                
                Client().send(request) { completion in
                    switch completion {
                    case .success:
                        break
                    case .failure(let error):
                        print(error)
                    }
                    lock.signal()
                }
                lock.wait()
            }
        
    }
}

private extension SpotiFriend {
    enum Errors: Error {
        case missingToken
        case errorFindingMe
    }
}

private extension SpotiFriend {
    /// Fetches the current OAuth token
    /// - Throws: `KeychainError`
    /// - Returns: The current OAuth token
    static func fetchToken() throws -> String {
        guard let token = try Keychain.fetch(key: "playlists.spotify.access_token") else {
            throw Errors.missingToken
        }
        
        return token
    }
    
    /// Requests the current users identity and returns a Publisher for the response
    /// - Parameter token: Valid OAuth token
    /// - Returns: A publisher for the response
    static func findme(token: String) -> AnyPublisher<User, ClientError> {
        let request = SpotifyRequest<User>(
            endpoint: "me",
            method: .GET,
            token: token
            
        )
        return Client().send(request).map { $0.data }.eraseToAnyPublisher()
    }
    
    /// Fetch playlists for a given user `id`
    /// - Parameters:
    ///   - id: The user `id` to request playlists for
    ///   - token: Valid OAuth token
    /// - Returns: A publisher for the result
    static func playlists(_ id: String, token: String) -> AnyPublisher<Page<Playlist>, ClientError> {
        let request = SpotifyRequest<Page<Playlist>> (
            endpoint: "users/\(id)/playlists",
            method: .GET,
            token: token
        )
        
        return Client().send(request).map { $0.data }.eraseToAnyPublisher()
    }
    
    /// Pages all the pages for a response
    /// - Parameters:
    ///   - page: The page to start paging on
    ///   - token: Valid OAuth token
    /// - Returns: An array of page objects
    static func paginate<T: Decodable>(_ page: Page<T>, token: String) -> [Page<T>]  {
        var output = [page]
        let lock = Semaphore()
        
        guard let next = page.nextRequest(token: token) else { return output }
        
        Client().send(next) { completion in
            switch completion {
            case .success(let result):
                output += paginate(result.data, token: token)
            case .failure(let error):
                print(error)
            }
            lock.signal()
        }
        lock.wait()
        
        return output
    }
}
