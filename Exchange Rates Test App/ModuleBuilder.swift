//
//  ModuleBuilder.swift
//  Exchange Rates Test App
//
//  Created by Olha Skulska on 2019. 12. 06..
//  Copyright © 2019. Olha Skulska. All rights reserved.
//

import UIKit

protocol Builder {
    static func createMainModule() -> UIViewController
    static func createDetailModule() -> UIViewController
}

class ModuleBuilder: Builder{
    
    static func createMainModule() -> UIViewController {
//        let currencyModel = Currency(name: "", rates: 2.344)
        let view = MainViewController()
        let network = NetworkService()
        let presenter = MainPresenter(view: view, network: network)
        view.presenter = presenter
        return view
    }
    
    static func createDetailModule() -> UIViewController {
            let view = DetailViewController()
            let network = NetworkService()
            let presenter = DetailPresenter(view: view, network: network)
            view.presenter = presenter
            return view
        }
}
