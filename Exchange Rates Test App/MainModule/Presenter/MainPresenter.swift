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
    func showLoadingAnimation()
    func stopShowingLoadingAnimation()
}

protocol MainViewPresenterProtocol: AnyObject {
    init(view: MainViewProtocol, network: NetworkServiceProtocol, db: RealmServiceProtocol)
    func getCurrencyFromAPI()
    var currencyRates: Results<Curr>? { get }
}

class MainPresenter: MainViewPresenterProtocol {
    var currencyRates: Results<Curr>?
    weak var view: MainViewProtocol?
    let network: NetworkServiceProtocol!
    let db: RealmServiceProtocol!
    var timer = Timer()
    
    required init(view: MainViewProtocol, network: NetworkServiceProtocol, db: RealmServiceProtocol) {
        self.view = view
        self.network = network
        self.db = db
        
//        self.timer = Timer.scheduledTimer(timeInterval: 10, target: self, selector: #selector(fireTimer), userInfo: nil, repeats: true)
        
        //                try! self.db.realm.write {
        //                    db.realm.deleteAll()
        //                }
        checkShouldRefreshData{ [weak self] isModified in
            guard let self = self else {return}
            (isModified && !((self.db.realm.isEmpty))) ?  currencyRates = db.realm.objects(Curr.self) : self.getCurrencyFromAPI()
        }
    }
    
    @objc func fireTimer(){
        getCurrencyFromAPI()
        print("timer")
    }
    
    func getCurrencyFromAPI() {
        print("i am here")
        network.getCurrencyRate { [weak self] result in
            guard let self = self else {return}
            DispatchQueue.main.async {
                switch result {
                case .failure:
                    self.view?.failureRequest()
                case .success(let currency):
                    self.saveToDB(currency: currency)
                    self.currencyRates = self.db.realm.objects(Curr.self)
                    self.view?.successRequest()
                }
            }
        }
    }
    
    private func saveToDB(currency: Dictionary<String, Any>) {
        if db.realm.isEmpty {
            db.createObjects(from: currency)
        } else {
            db.deleteObjects()
            db.createObjects(from: currency)
        }
    }
    
    private func checkShouldRefreshData(completion:(Bool) -> ()) {
        
        let lastModifiedDate = UserDefaults.standard.object(forKey: "LastModifiedDate")
        
        if  lastModifiedDate == nil {
            UserDefaults.standard.set(Date(), forKey: "LastModifiedDate")
            completion(false)
        } else {
            let interval = Date().timeIntervalSince(lastModifiedDate as! Date)
            print(interval)
            if interval > 10*60{
                UserDefaults.standard.set(Date(), forKey: "LastModifiedDate")
                completion(false)
            }
        }
        completion(true)
    }
    deinit {
        self.timer.invalidate()
    }
}

