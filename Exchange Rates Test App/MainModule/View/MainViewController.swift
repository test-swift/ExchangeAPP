//
//  ViewController.swift
//  Exchange Rates Test App
//
//  Created by Olha Skulska on 2019. 12. 06..
//  Copyright © 2019. Olha Skulska. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {

//    @IBOutlet var currencyNameLabel: UILabel!
//    @IBOutlet var currencyRateLabel: UILabel!
    
    @IBOutlet weak var tableView: UITableView!
    
    var presenter: MainViewPresenterProtocol!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        print(presenter.currencyRates?.count)
    }
}

extension MainViewController: UITableViewDataSource, UITableViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter.currencyRates?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        cell.textLabel?.text = presenter.currencyRates?[indexPath.row].name
//        cell.textLabel?.text = presenter.currencyRates?[indexPath.row].rates
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = ModuleBuilder.createDetailModule()
        present(vc, animated: true, completion: nil)
    }
}


extension MainViewController: MainViewProtocol{
    
    func successRequest() {
        tableView.reloadData()
    }
    
    func failureRequest() {
        print("error")
    }
    
    func setRates(rates: String) {
        
    }
}
