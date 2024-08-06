//
//  ToppingModel.swift
//  dev
//
//  Created by phan dam tung lam on 30/7/24.
//

import Foundation

class ToppingModel : Hashable, Identifiable {
    static func == (
        lhs: ToppingModel,
        rhs: ToppingModel
      ) -> Bool {
        lhs.hashValue == rhs.hashValue
      }
    
    var name: String
    var type: String
    var options: [String]
    
    init(name: String, type: String, options: [String]) {
        self.name = name
        self.type = type
        self.options = options
    }
    
    func hash(into hasher: inout Hasher) {
           hasher.combine(name)
           hasher.combine(type)
           hasher.combine(options)
       }
}
