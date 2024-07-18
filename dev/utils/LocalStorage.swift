//
//  LocalStorage.swift
//  dev
//
//  Created by phan dam tung lam on 17/7/24.
//

import Foundation
import UIKit

protocol LocalStorage {
    associatedtype T: Codable
    func save(_ value: T) -> Bool
    func load() -> T?
    func remove() -> Bool
}

class ShoppingCartLocalStorage<T: Codable> : LocalStorage {
    private let defaults : UserDefaults;
    private let keyName: String = "shopping_cart";
    
    init(sharedPrefs: UserDefaults) {
        self.defaults = UserDefaults.standard
    }
    
    func save(_ value: T) -> Bool {
        if let encoded = try? JSONEncoder().encode(value) {
            defaults.set(encoded, forKey: self.keyName)
            return true;
        }
        return false;
    }
    
    func load() -> T? {
        if let data = defaults.data(forKey: self.keyName),
           let decoded = try? JSONDecoder().decode(T.self, from: data) {
            return decoded
        }
        return nil
    }
    
    func remove() -> Bool {
         defaults.removeObject(forKey: self.keyName)
         return true;
       
    }
}
