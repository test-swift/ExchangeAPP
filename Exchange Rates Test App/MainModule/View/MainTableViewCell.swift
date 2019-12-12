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
        
        //MARK: Set cell UI
        self.cellView.layer.cornerRadius = 7
        self.cellView.backgroundColor = UIColor(red:0.51, green:0.72, blue:0.29, alpha:0.6)
        self.translatesAutoresizingMaskIntoConstraints = false
        self.contentView.backgroundColor = UIColor.white
        self.selectionStyle = .none
        
        currencyName.font = UIFont(name: "Arial-BoldMT", size: 18)
        currencyName.textColor = UIColor(red:0.24, green:0.27, blue:0.27, alpha:1.0)
        currencyValue.font = UIFont(name: "ArialMT-BoldMT", size: 16)
        currencyValue.textColor = UIColor(red:0.9, green:0.58, blue:0.42, alpha:1.0)
        
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)


    }
}
