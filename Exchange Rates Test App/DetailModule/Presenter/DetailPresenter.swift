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
    func showLoadingAnimation()
    func stopShowingLoadingAnimation()
    func setLabels(minValue: String, maxValue: String, imgName: String)
}

protocol DetailViewPresenterPrototcol: AnyObject {
    init(view: DetailViewProtocol, network: NetworkServiceProtocol, symbol: String)
    func getRateHistory()
    func setData(data: [String: Double])
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
                self.view?.showLoadingAnimation()
                switch result {
                case .failure:
                    self.view?.stopShowingLoadingAnimation()
                    self.view?.failureRequest()
                case .success(let data):
                    self.setData(data: data)
                    self.view?.stopShowingLoadingAnimation()
                }
            }
        }
    }
    
    func setData(data: [String: Double]) {
        var imageName: String
        let sorted = data.sorted{$0.key < $1.key}
        if sorted.first?.value ?? 0 > sorted.last?.value ?? 0{
            imageName = "reduction"
        } else { imageName = "income" }
        let label = sorted.map({ $0.key })
        let exchangeData = sorted.map({ $0.value })
        let minValue = String(format:"%.4f", data.values.min() ?? 0)
        let maxValue = String(format:"%.4f", data.values.max() ?? 0)
        self.view?.setChart(values: exchangeData, label: label)
        self.view?.setLabels(minValue: minValue, maxValue: maxValue, imgName: imageName)
    }
    
    private  func getDateForRequest() -> (String, String){
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let currDate = dateFormatter.string(from: Date())
        let  prev = Calendar.current.date(byAdding: .day, value: -7, to: Date())
        let oldDate = dateFormatter.string(from: prev!)
        return(oldDate, currDate)
    }
}
