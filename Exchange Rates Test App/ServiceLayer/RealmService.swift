//
//  DataBaseLayer.swift
//  Exchange Rates Test App
//
//  Created by Olha Skulska on 2019. 12. 09..
//  Copyright © 2019. Olha Skulska. All rights reserved.
//

import Foundation
import RealmSwift

protocol RealmServiceProtocol: AnyObject {
    func deleteObjects()
    func createObjects(from dictionary: [String: Any])
    var realm: Realm { get }
}

class RealmService: RealmServiceProtocol{
    //    var realm = try! Realm(configuration: Realm.Configuration(deleteRealmIfMigrationNeeded: true))
    var realm = try! Realm()
    func deleteObjects() {
        do {
            try realm.write{
                realm.deleteAll()
            }
        } catch {
            print(error)
        }
    }
    
    func createObjects(from dictionary: [String: Any]) {
        var objs = [Curr]()
        let sortedDict = dictionary.sorted{$0.key > $1.key}
        for (key, value) in sortedDict{
            guard let value = value as? Double else {return}
            if key == "USD" {continue}
            objs.append(Curr(name: key, rates: value))
        }
        do {
            try realm.write {
                realm.add(objs, update: .modified)
            }
        } catch {
            print(error)
        }
    }
}
