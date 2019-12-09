//
//  DetailViewController.swift
//  Exchange Rates Test App
//
//  Created by Olha Skulska on 2019. 12. 09..
//  Copyright © 2019. Olha Skulska. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
    
    var presenter: DetailViewPresenterPrototcol!
    @IBOutlet weak var nameLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

}

extension DetailViewController: DetailViewProtocol{
    
}
