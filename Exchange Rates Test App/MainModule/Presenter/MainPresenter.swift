//
//  MainPresenter.swift
//  Exchange Rates Test App
//
//  Created by Olha Skulska on 2019. 12. 06..
//  Copyright © 2019. Olha Skulska. All rights reserved.
//

import Foundation

protocol MainViewProtocol: AnyObject{
    func setRates(rates: String)
    func successRequest()
    func failureRequest()
}

protocol MainViewPresenterProtocol: AnyObject {
    init(view: MainViewProtocol, network: NetworkServiceProtocol)
    func getCurrency()
    var currencyRates: [Currency]? {get set}
}

class MainPresenter: MainViewPresenterProtocol {

    var currencyRates: [Currency]?
    let view: MainViewProtocol
    let network: NetworkServiceProtocol
    
    
    required init(view: MainViewProtocol, network: NetworkServiceProtocol) {
        self.view = view
        self.network = network
//        getCurrency()
        checkShouldRefreshData{ [weak self] isModified in
            isModified ? self?.getFromDB() : self?.getCurrency()
        }
            
    }
    
    func getCurrency() {
        print("from Request")
        network.getCurrencyRate { [weak self] result in
            DispatchQueue.main.async {
            switch result {
            case .failure(let error):
                self?.view.failureRequest()
            case .success(let currency):
                self?.currencyRates = currency
                print(self?.currencyRates)
                self?.view.successRequest()
            }
            }
        }
    }
    
    func getFromDB(){
        print("from db")
    }
    
    func checkShouldRefreshData(completion:(Bool) -> ()) {
       
        let lastModifiedDate = UserDefaults.standard.object(forKey: "LastModifiedDate")
        let interval = Date().timeIntervalSince(lastModifiedDate as! Date)
    
        print(interval, lastModifiedDate)
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
