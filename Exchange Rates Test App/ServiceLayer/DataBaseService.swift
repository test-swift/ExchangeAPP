//
//  DataBaseLayer.swift
//  Exchange Rates Test App
//
//  Created by Olha Skulska on 2019. 12. 09..
//  Copyright © 2019. Olha Skulska. All rights reserved.
//

import Foundation
import RealmSwift

protocol DataBaseServiceProtocol {
    func deleteObject(obj: Object)
    func saveObject(obj: Object)
    func editObjects(objs: Object)
}
