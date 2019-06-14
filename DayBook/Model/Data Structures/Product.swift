//
//  Product.swift
//  DayBook
//
//  Created by Илья on 6/14/19.
//  Copyright © 2019 Илья. All rights reserved.
//

import Foundation

struct Product {
    let id: Int
    var productName: String
    
    init(id: Int, productName: String) {
        self.id = id
        self.productName = productName
    }
}
