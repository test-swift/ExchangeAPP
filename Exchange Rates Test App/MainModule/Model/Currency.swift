//
//  Currency.swift
//  Exchange Rates Test App
//
//  Created by Olha Skulska on 2019. 12. 06..
//  Copyright © 2019. Olha Skulska. All rights reserved.
//

import Foundation
import RealmSwift

class Curr: Object {
    
    @objc dynamic var name = ""
    @objc dynamic var rates = ""
    @objc dynamic var ID = UUID().uuidString
    
    override static func primaryKey() -> String? {
      return "ID"
    }
    
    convenience init(name: String, rates: Double) {
        self.init()
        self.name = name
        self.rates = String(format:"%.2f", rates)
    }
}
