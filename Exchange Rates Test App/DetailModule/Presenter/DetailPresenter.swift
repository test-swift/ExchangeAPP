//
//  DetailPresenter.swift
//  Exchange Rates Test App
//
//  Created by Olha Skulska on 2019. 12. 09..
//  Copyright © 2019. Olha Skulska. All rights reserved.
//

import Foundation

protocol DetailViewProtocol{
//    func se
}

protocol DetailViewPresenterPrototcol {
    init(view: DetailViewProtocol, network: NetworkServiceProtocol)
    func getRateHistory()
}


class DetailPresenter: DetailViewPresenterPrototcol{
        
    let view: DetailViewProtocol
    let network: NetworkServiceProtocol
    
    required init(view: DetailViewProtocol, network: NetworkServiceProtocol) {
        self.network = network
        self.view = view
        getRateHistory()
    }
    
    func getRateHistory() {
        network.getCurrencyRateHistory { [weak self] result in
        }
    }
}
