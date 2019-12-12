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
            post(error)
        }
    }
    
    func createObjects(from dictionary: [String: Any]) {
        var objs = [Curr]()
        let sortedDict = dictionary.sorted{$0.key > $1.key}

        for (key, value) in sortedDict{
            guard let value = value as? Double else {return}
            objs.append(Curr(name: key, rates: value))
        }
        do {
            try realm.write {
                realm.add(objs, update: .modified)
            }
        } catch {
            post(error)
        }
    }
    
    
    private func post(_ error: Error){
        NotificationCenter.default.post(name: Notification.Name("RealmError"), object: error)
    }
}
