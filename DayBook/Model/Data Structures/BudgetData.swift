//
//  BudgetData.swift
//  DayBook
//
//  Created by Илья on 6/13/19.
//  Copyright © 2019 Илья. All rights reserved.
//

import Foundation

struct BudgetData {
    var sum: Double
    var comment: String
    let id: Int
    
    init(sum: Double, comment:String, id: Int) {
        self.sum = sum
        self.comment = comment
        self.id = id
    }
    
    init(){
        self.sum = 0
        self.comment = "No comment"
        self.id = Int(arc4random())
    }
}
