//
//  DetailPresenter.swift
//  Exchange Rates Test App
//
//  Created by Olha Skulska on 2019. 12. 09..
//  Copyright © 2019. Olha Skulska. All rights reserved.
//

import Foundation

protocol DetailViewProtocol: AnyObject{
    func successRequest()
    func failureRequest()
    func setChart(values: [Double], label: [String])
}

protocol DetailViewPresenterPrototcol: AnyObject {
    init(view: DetailViewProtocol, network: NetworkServiceProtocol, symbol: String)
    func getRateHistory()
    var symbol: String { get  }
}


class DetailPresenter: DetailViewPresenterPrototcol{
    var symbol: String
    weak var view: DetailViewProtocol?
    let network: NetworkServiceProtocol!
    var label: [String] = []
    var date: [Double] = []
    
    
    
    required init(view: DetailViewProtocol, network: NetworkServiceProtocol, symbol: String) {
        self.network = network
        self.view = view
        self.symbol = symbol
        getRateHistory()
    }
    
    
    func getDateForRequest() -> (String, String){
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let currDate = dateFormatter.string(from: Date())
        let  prev = Calendar.current.date(byAdding: .day, value: -7, to: Date())
        let oldDate = dateFormatter.string(from: prev!)
        print(currDate, oldDate)
        return(oldDate, currDate)
    }
    
    
    func getRateHistory() {
        network.getCurrencyRateHistory(symbols: symbol, fromTo: getDateForRequest()){ [weak self] result in
           DispatchQueue.main.async {
            switch result {
            case .failure:
                self?.view?.failureRequest()
            case .success(let data):
                 let sorted = data.sorted{$0.key > $1.key}
                 print(sorted)
                self?.label = sorted.map({ $0.key })
                self?.date = sorted.map({ $0.value })
                 self?.view?.setChart(values: self!.date, label: self!.label)
            }
            }
        }
    }
}
