//
//  DetailPresenter.swift
//  Exchange Rates Test App
//
//  Created by Olha Skulska on 2019. 12. 09..
//  Copyright © 2019. Olha Skulska. All rights reserved.
//

import Foundation

protocol DetailViewProtocol: AnyObject{
    func setChart(values: [Double], label: [String])
    func failureRequest()
}

protocol DetailViewPresenterPrototcol: AnyObject {
    init(view: DetailViewProtocol, network: NetworkServiceProtocol, symbol: String)
    func getRateHistory()
    var symbol: String { get }
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
    
    func getRateHistory() {
        network.getCurrencyRateHistory(symbols: symbol, fromTo: getDateForRequest()){ [weak self] result in
            guard let self = self else {return}
            DispatchQueue.main.async {
                switch result {
                case .failure:
                    self.view?.failureRequest()
                case .success(let data):
                    let sorted = data.sorted{$0.key < $1.key}
                    self.label = sorted.map({ $0.key })
                    self.date = sorted.map({ $0.value })
                    self.changeDate(date: self.label)
                    self.view?.setChart(values: self.date, label: self.label)
                }
            }
        }
    }
    
    private  func getDateForRequest() -> (String, String){
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let currDate = dateFormatter.string(from: Date())
        let  prev = Calendar.current.date(byAdding: .day, value: -7, to: Date())
        let oldDate = dateFormatter.string(from: prev!)
        return(oldDate, currDate)
    }
    
    private func changeDate(date: [String]) -> [String]{
        
       let dateFormatter = DateFormatter()
       dateFormatter.dateFormat = "yyyy-MM-dd"
       dateFormatter.locale = Locale.init(identifier: "en_GB")
        let newDate: [String] = []
        for dateString in date {
            print(dateString)
        let dateObj = dateFormatter.date(from: dateString)
        
        dateFormatter.dateFormat = "MMM dd"
            print(dateObj)
//            newDate.append(dateFormatter.string(from: dateObj!))
//        print("Dateobj:", newDate)
        }
        return newDate
    }
}
