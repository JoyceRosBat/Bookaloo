//
//  Storage.swift
//  Bookaloo
//
//  Created by Joyce Rosario Batista on 2/2/23.
//

import Foundation

class Storage {
    static let shared = Storage()
    
    private init() {}
    
    func save<T: Codable>(_ item: T, key: StorageKeys) {
        do {
            let data = try JSONEncoder().encode(item)
            save(data, key: key)
        } catch {
            assertionFailure("Fail to encode item for keychain: \(error)")
        }
    }

    func get<T: Codable>(key: StorageKeys, type: T.Type) -> T? {
        guard let data = read(key) else {
            return nil
        }
        
        do {
            let item = try JSONDecoder().decode(type, from: data)
            return item
        } catch {
            assertionFailure("Fail to decode item for keychain: \(error)")
            return nil
        }
    }
    
    func remove(_ key: StorageKeys) {
        let query = [
            kSecAttrService: KeychainConfiguration.service,
            kSecAttrAccount: key.rawValue,
            kSecClass: kSecClassGenericPassword,
        ] as CFDictionary
        
        SecItemDelete(query)
    }
    
    func cleanAll() {
        StorageKeys.allCases.forEach { remove($0) }
    }
}

private extension Storage {
    func save(_ data: Data, key: StorageKeys) {
        let query = [
            kSecValueData: data,
            kSecClass: kSecClassGenericPassword,
            kSecAttrService: KeychainConfiguration.service,
            kSecAttrAccount: key.rawValue,
        ] as CFDictionary
        
        let status = SecItemAdd(query, nil)
        
        if status != errSecSuccess {
            print("Error: \(status)")
        }
        
        if status == errSecDuplicateItem {
            let query = [
                kSecAttrService: KeychainConfiguration.service,
                kSecAttrAccount: key.rawValue,
                kSecClass: kSecClassGenericPassword,
            ] as CFDictionary
            
            let attributesToUpdate = [kSecValueData: data] as CFDictionary
            SecItemUpdate(query, attributesToUpdate)
        }
    }
    
    func read(_ key: StorageKeys) -> Data? {
        let query = [
            kSecAttrService: KeychainConfiguration.service,
            kSecAttrAccount: key.rawValue,
            kSecClass: kSecClassGenericPassword,
            kSecReturnData: true
        ] as CFDictionary
        
        var result: AnyObject?
        SecItemCopyMatching(query, &result)
        
        return (result as? Data)
    }
}
