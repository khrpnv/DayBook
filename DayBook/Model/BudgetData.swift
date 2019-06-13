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
    var lose: Bool
    
    init(sum: Double, comment:String, lose: Bool) {
        self.sum = sum
        self.comment = comment
        self.lose = lose
    }
    
    init(){
        self.sum = 0
        self.comment = ""
        self.lose = false
    }
}
