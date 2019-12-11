//
//  ModuleBuilder.swift
//  Exchange Rates Test App
//
//  Created by Olha Skulska on 2019. 12. 06..
//  Copyright © 2019. Olha Skulska. All rights reserved.
//

import UIKit

protocol Builder {
//    static func createMainModule() -> UIViewController
    static func createDetailModule(for symbol: String) -> UIViewController
}

class ModuleBuilder: Builder{
    
    static func createMainModule() -> UIViewController {
        let view = MainViewController()
        let db = RealmService()
        let network = NetworkService()
        let presenter = MainPresenter(view: view, network: network, db: db)
        view.presenter = presenter
        return view
    }
    
    static func createDetailModule(for symbol: String) -> UIViewController {
        let view = DetailViewController()
        let network = NetworkService()
        let presenter = DetailPresenter(view: view, network: network, symbol: symbol)
            view.presenter = presenter
            return view
        }
}
