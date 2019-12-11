//
//  ViewController.swift
//  Exchange Rates Test App
//
//  Created by Olha Skulska on 2019. 12. 06..
//  Copyright © 2019. Olha Skulska. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    var presenter: MainViewPresenterProtocol!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let mainTableCell = UINib(nibName: "MainTableViewCell", bundle: nil)
        tableView.register(mainTableCell, forCellReuseIdentifier: "MainTableViewCell")
        setBasicUI()
    }
    
    func setBasicUI(){
        tableView.separatorStyle = .none
        
        let navLabel = UILabel()
        let navTitle = NSMutableAttributedString(string: "Exchange Rate", attributes:[
            NSAttributedString.Key.foregroundColor: UIColor(red:0.95, green:0.89, blue:0.87, alpha:1.0),
            NSAttributedString.Key.font: UIFont.systemFont(ofSize: 18.0, weight: UIFont.Weight.bold)])
        
        navLabel.attributedText = navTitle
        self.navigationItem.titleView = navLabel
        self.navigationController?.navigationBar.topItem?.titleView = navLabel
        
        self.navigationController?.navigationBar.barTintColor = UIColor(red:0.40, green:0.45, blue:0.57, alpha:0.5)
        self.navigationController?.navigationBar.shadowImage =  UIImage()
        self.view.backgroundColor = UIColor(red:0.40, green:0.45, blue:0.57, alpha:0.6)
    }
}

extension MainViewController: UITableViewDataSource, UITableViewDelegate{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter.currencyRates?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MainTableViewCell", for: indexPath) as! MainTableViewCell
        cell.currencyName.text = presenter.currencyRates?[indexPath.row].name
        cell.currencyValue.text = presenter.currencyRates?[indexPath.row].rates
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = ModuleBuilder.createDetailModule(for: (presenter.currencyRates?[indexPath.row].name)!)
        show(vc, sender: self)
    }
}

extension MainViewController: MainViewProtocol{
        
    func successRequest() {
        tableView.reloadData()
    }
    
    func failureRequest() {
        print("error")
    }
}
