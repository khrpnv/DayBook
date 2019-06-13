//
//  BudgetTableViewCell.swift
//  DayBook
//
//  Created by Илья on 6/13/19.
//  Copyright © 2019 Илья. All rights reserved.
//

import UIKit

class BudgetTableViewCell: UITableViewCell {

    @IBOutlet private weak var dataIndicatorLabel: UILabel!
    @IBOutlet private weak var sum: UILabel!
    @IBOutlet private weak var commentLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func initCell(indicator: String, sum: Double, comment: String){
        dataIndicatorLabel.text = indicator
        self.sum.text = "\(sum)"
        commentLabel.text = comment
        if indicator == "-"{
            dataIndicatorLabel.textColor = #colorLiteral(red: 1, green: 0, blue: 0.107809104, alpha: 1)
        } else {
            dataIndicatorLabel.textColor = #colorLiteral(red: 0.4666666687, green: 0.7647058964, blue: 0.2666666806, alpha: 1)
        }
    }

}
