//
//  Currency.swift
//  Exchange Rates Test App
//
//  Created by Olha Skulska on 2019. 12. 06..
//  Copyright © 2019. Olha Skulska. All rights reserved.
//

import Foundation

struct Currency: Decodable{
    let name: String
    let rates: Double
}
