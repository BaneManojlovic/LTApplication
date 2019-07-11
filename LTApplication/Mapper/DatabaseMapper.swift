//
//  DatabaseMapper.swift
//  LTApplication
//
//  Created by Branislav Manojlovic on 4/20/1398 AP.
//  Copyright © 1398 Branislav Manojlovic. All rights reserved.
//

import Foundation

struct DatabaseMapper {
    
    static func saveUser(_ user: UserModel) throws {
        try DatabaseMapper.encodeAndSaveObject(user, forKey: .user)
    }
    
    static func getUser() -> UserModel? {
        return DatabaseMapper.decodeObject(forKey: .user)
    }
    
    private static func encodeAndSaveObject<T: Encodable>(_ object: T, forKey key: UserDefaultKeys) throws {
        let encoded = try JSONEncoder().encode(object)
        DatabaseMapper.saveToUserDefaults(encoded, forKey: key)
    }
    
    private static func saveToUserDefaults(_ object: Any, forKey key: UserDefaultKeys) {
        UserDefaults.standard.set(object, forKey: key.rawValue)
        UserDefaults.standard.synchronize()
    }
    
    private static func decodeObject<T: Decodable>(forKey key: UserDefaultKeys) -> T? {
        do {
            if let encoded = DatabaseMapper.getObject(key: key) as? Data {
                let decoded = try JSONDecoder().decode(T.self, from: encoded)
                return decoded
            } else {
                return nil
            }
        } catch {
            debugPrint("FAILURE: \(error.localizedDescription)")
            return nil
        }
    }
    
    private static func getObject(key: UserDefaultKeys) -> Any? {
        return UserDefaults.standard.object(forKey: key.rawValue)
    }

    static func saveFCMToken(_ token: String) {
        saveToUserDefaults(token, forKey: .fcmToken)
    }

}
