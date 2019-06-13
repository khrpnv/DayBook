//
//  String+extension.swift
//  DayBook
//
//  Created by Илья on 6/13/19.
//  Copyright © 2019 Илья. All rights reserved.
//

import Foundation

extension String {
    func toDouble() -> Double? {
        return NumberFormatter().number(from: self)?.doubleValue
    }
}
