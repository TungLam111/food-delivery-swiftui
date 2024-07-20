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
    func _save(_ value: [T]) -> Bool
    func saveOne(_ value: T) -> Bool
    func load() -> [T]?
    func removeOne(by item: T) -> Bool
    func remove() -> Bool
}

class ShoppingCartLocalStorage : LocalStorage {
    
    private let defaults : UserDefaults;
    private let keyName: String = "shopping_cart";
    
    init(sharedPrefs: UserDefaults) {
        self.defaults = UserDefaults.standard
    }
    
    func _save(_ value: [CartItem]) -> Bool {
        if let encoded = try? JSONEncoder().encode(value) {
            defaults.set(encoded, forKey: self.keyName)
            return true;
        }
        return false;
    }
    
    
    func saveOne(_ value: CartItem) -> Bool {
        if let data = self.defaults.data(forKey: keyName),
               let decoded = try? JSONDecoder().decode([CartItem].self, from: data) {
                var newList = decoded
            if let index = newList.firstIndex(where: { $0.id == value.id }) {
                    newList[index].quantity += 1
                } else {
                    newList.append(value)
                }
                return self._save(newList)
            } else {
                return self._save([value])
            }
        }
    
    func load() -> [CartItem]? {
        if let data = defaults.data(forKey: self.keyName),
           let decoded = try? JSONDecoder().decode([CartItem].self, from: data) {
            return decoded
        }
        return nil
    }

    func remove() -> Bool {
        defaults.removeObject(forKey: self.keyName)
        return true;
    }
    
    func removeOne(by value: CartItem) -> Bool {
        if let data = self.defaults.data(forKey: keyName),
             let decoded = try? JSONDecoder().decode([CartItem].self, from: data) {
              var newList = decoded
            if let index = newList.firstIndex(where: { $0.id == value.id }) {
                  newList[index].quantity -= 1
                  if newList[index].quantity <= 0 {
                      newList.remove(at: index)
                  }
                  return self._save(newList)
              }
          }
          return false
      }
}
