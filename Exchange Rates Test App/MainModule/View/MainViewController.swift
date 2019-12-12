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
    var activityIndicator: UIActivityIndicatorView = UIActivityIndicatorView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let mainTableCell = UINib(nibName: "MainTableViewCell", bundle: nil)
        tableView.register(mainTableCell, forCellReuseIdentifier: "MainTableViewCell")
        setBasicUI()
    }
    
    private func setBasicUI(){
        
        tableView.separatorStyle = .none
        //MARK: Set Top NavBar
        let navLabel = UILabel()
        let navTitle = NSMutableAttributedString(string: "Exchange Rate", attributes:[
            NSAttributedString.Key.foregroundColor: UIColor.white,
            NSAttributedString.Key.font: UIFont.systemFont(ofSize: 18.0, weight: UIFont.Weight.bold)])
        navLabel.attributedText = navTitle
        self.navigationItem.titleView = navLabel
        self.navigationController?.navigationBar.topItem?.titleView = navLabel
        self.navigationController?.navigationBar.barTintColor = UIColor(red:0.51, green:0.72, blue:0.29, alpha:1.0)
        self.navigationController?.navigationBar.isTranslucent = false
        self.navigationController?.navigationBar.shadowImage =  UIImage()
        self.view.backgroundColor = UIColor(red:0.51, green:0.72, blue:0.29, alpha:1.0)
        self.navigationController?.navigationItem.leftBarButtonItem?.tintColor = UIColor.white
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
    func showLoadingAnimation() {
        activityIndicator.center = self.view.center
        activityIndicator.hidesWhenStopped = true
        activityIndicator.style = .large
        activityIndicator.color = .green
        view.addSubview(activityIndicator)
        activityIndicator.startAnimating()
    }
    
    func stopShowingLoadingAnimation() {
        activityIndicator.stopAnimating()
    }
    
    func successRequest() {
        activityIndicator.stopAnimating()
        tableView.reloadData()
    }
    
    func failureRequest() {
        let alert = UIAlertController(title: "An Error Occurred", message: "Service Not Available at this moment", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
        self.present(alert, animated: true)
    }
}
