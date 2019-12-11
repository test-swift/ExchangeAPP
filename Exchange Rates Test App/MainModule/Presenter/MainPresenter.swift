//
//  MainPresenter.swift
//  Exchange Rates Test App
//
//  Created by Olha Skulska on 2019. 12. 06..
//  Copyright © 2019. Olha Skulska. All rights reserved.
//

import Foundation
import RealmSwift

protocol MainViewProtocol: AnyObject{
    func successRequest()
    func failureRequest()
}

protocol MainViewPresenterProtocol: AnyObject {
    init(view: MainViewProtocol, network: NetworkServiceProtocol, db: RealmServiceProtocol)
    func getCurrencyFromAPI()
    var currencyRates: Results<Curr>? { get set}
    func saveToDB(currency: Dictionary<String, Any>)
}

class MainPresenter: MainViewPresenterProtocol {
    
    var currencyRates: Results<Curr>?
    weak var view: MainViewProtocol?
    let network: NetworkServiceProtocol!
    let db: RealmServiceProtocol!
    
    required init(view: MainViewProtocol, network: NetworkServiceProtocol, db: RealmServiceProtocol) {
        self.view = view
        self.network = network
        self.db = db
//
//        try! self.db.realm.write {
//            db.realm.deleteAll()
//        }
        print(Realm.Configuration())
        checkShouldRefreshData{ [weak self] isModified in
            (isModified && !((self?.db.realm.isEmpty)!)) ?  currencyRates = db.realm.objects(Curr.self) : self?.getCurrencyFromAPI()
        }
    }
    
    func getCurrencyFromAPI() {
        print("From api")
        network.getCurrencyRate { [weak self] result in
            DispatchQueue.main.async {
            switch result {
            case .failure:
                self?.view?.failureRequest()
            case .success(let currency):
                self?.saveToDB(currency: currency)
                self?.currencyRates = self?.db.realm.objects(Curr.self)
                self?.view?.successRequest()
            }
            }
        }
    }
    
    func saveToDB(currency: Dictionary<String, Any>) {
        if db.realm.isEmpty {
            db.createObjects(from: currency as! [String : Double])
        } else {
            db.updateObjects(with: currency as! [String : Double])
        }
     }
    
    
    func checkShouldRefreshData(completion:(Bool) -> ()) {
       
        let lastModifiedDate = UserDefaults.standard.object(forKey: "LastModifiedDate")
        let interval = Date().timeIntervalSince(lastModifiedDate as! Date)
    
        print(interval)
        if  lastModifiedDate == nil {
            UserDefaults.standard.set(Date(), forKey: "LastModifiedDate")
            completion(false)
        } else {
            if interval > 10*60{
                print("refresh")
                UserDefaults.standard.set(Date(), forKey: "LastModifiedDate")
                completion(false)
            }
        }
        completion(true)
    }
    
}
