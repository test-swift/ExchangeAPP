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
    
    func updateObjects(with param: [String: Double])
    func createObjects(from dictionary: [String: Double])
    var realm: Realm { get }
}


class RealmService: RealmServiceProtocol{

//     lazy var comf = Realm.Configuration(deleteRealmIfMigrationNeeded: true)
//    var realm = try! Realm(configuration: Realm.Configuration(deleteRealmIfMigrationNeeded: true))
     var realm = try! Realm()
    
    func updateObjects(with dictionary: [String: Double]) {
        
        let objs = realm.objects(Curr.self)
        
        do {
            try realm.write{
                realm.add(objs, update: .modified)
            }
        } catch {
            print(error)
            }
    
    }
    
    func createObjects(from dictionary: [String: Double]) {
        
        var objs = [Curr]()

        for (key, value) in dictionary{
            objs.append(Curr(name: key, rates: value))
        }
        do {
            try realm.write {
                realm.add(objs, update: .modified)
            }
        } catch {
            
        }
    }

    
    
    
}
