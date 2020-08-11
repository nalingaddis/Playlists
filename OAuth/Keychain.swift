//
//  Keychain.swift
//  Playlists
//
//  Created by Nalin Gaddis on 7/18/20.
//  Copyright © 2020 Nalin Gaddis. All rights reserved.
//

import Foundation
import Security

struct Keychain {
    
    /// Create the base query for the given `key`
    /// - Parameter key: The name to create the query for
    /// - Throws: `Keychain.Errors`
    /// - Returns: A Sec Query object
    private static func createQuery(forKey key: String) throws -> [CFString: Any] {
        guard let keyData = key.data(using: .utf8) else {
            throw Keychain.Errors.keyToData(key)
        }
        
        return [
            kSecClass: kSecClassGenericPassword,
            kSecAttrGeneric: keyData,
            kSecAttrAccount: keyData
        ]
    }
    
    /// Stores a `value` under the name `key`
    /// - Parameters:
    ///   - value: The value to store
    ///   - key: The key name
    /// - Throws: `Keychain.Errors`
    static func store(_ value: String, forKey key: String) throws {
        guard let data = value.data(using: .utf8) else {
            throw Keychain.Errors.valueToData(value)
        }
        
        var query = try createQuery(forKey: key)
        query[kSecValueData] = data
        
        let status = SecItemAdd(query as CFDictionary, nil)
        
        switch status {
        case errSecSuccess:
            return
        case errSecDuplicateItem:
            try update(key, with: value)
        default:
            throw Keychain.Errors.storing(status.message)
        }
    }
    
    /// Updates a given `key` with a new `value`
    /// - Parameters:
    ///   - key: The key to update
    ///   - value: The new value
    /// - Throws: `Keychain.Errors`
    static func update(_ key: String, with value: String) throws {
        guard let data = value.data(using: .utf8) else {
            throw Keychain.Errors.valueToData(value)
        }
        
        let query = try createQuery(forKey: key)
        let update = [kSecValueData: data]
        
        let status = SecItemUpdate(query as CFDictionary, update as CFDictionary)
        
        guard status == errSecSuccess else {
            throw Keychain.Errors.updating(status.message)
        }
        
    }
    
    /// Fetches the value of a given `key`
    /// - Parameter key: The key name
    /// - Throws: `Keychain.Errors`
    /// - Returns: The value of the key if it exists, `nil` otherwise
    static func fetch(key: String) throws -> String {
        var query = try createQuery(forKey: key)
        query[kSecReturnData] = true
        
        var result: AnyObject?
        
        let status = SecItemCopyMatching(query as CFDictionary, &result)
        
        guard status == errSecSuccess else {
            throw Keychain.Errors.fetching(status.message)
        }
        
        guard let value = String(data: result as! Data, encoding: .utf8) else {
            throw Keychain.Errors.fetching("Failed to read stored value")
        }
        
        return value
    }
    
    /// Delete the value at a given `key`
    /// - Parameter key: The key to delete
    /// - Throws: `Keychain.Errors`
    static func delete(key: String) throws {
        let query = try createQuery(forKey: key)
        
        let status = SecItemDelete(query as CFDictionary)
        
        guard status == errSecSuccess else {
            throw Keychain.Errors.deleting(status.message)
        }
    }
}

extension Keychain {
    enum Errors: Error {
        /// Failed to convert a key into data
        case keyToData(String)
        /// Failed to convert a value into data
        case valueToData(String)
        /// Storing failed with status message
        case storing(String)
        /// Updating failed with status message
        case updating(String)
        /// Fetching failed with status message
        case fetching(String)
        /// Deleting failed with status message
        case deleting(String)
    }

}

extension OSStatus {
    var message: String {
        return (SecCopyErrorMessageString(self, nil) ?? "Unknown Error" as CFString) as String
    }
}
