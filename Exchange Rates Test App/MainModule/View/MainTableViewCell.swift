//
//  MainTableViewCell.swift
//  Exchange Rates Test App
//
//  Created by Olha Skulska on 2019. 12. 10..
//  Copyright © 2019. Olha Skulska. All rights reserved.
//

import UIKit

class MainTableViewCell: UITableViewCell {

    @IBOutlet weak var currencyName: UILabel!
    @IBOutlet weak var currencyValue: UILabel!
    @IBOutlet weak var cellView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        
        self.cellView.layer.cornerRadius = 7
        self.cellView.backgroundColor = UIColor(red:0.95, green:0.89, blue:0.87, alpha:0.6)
        self.translatesAutoresizingMaskIntoConstraints = false
        self.contentView.backgroundColor = UIColor(red:0.55, green:0.62, blue:0.71, alpha:1.0)
        
        currencyName.font = UIFont(name: "AvenirNextCondensed-Medium ", size: 15)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
}
