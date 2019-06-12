//
//  TagsEnum.swift
//  DayBook
//
//  Created by Илья on 6/12/19.
//  Copyright © 2019 Илья. All rights reserved.
//

import Foundation

enum Tag {
    case Task
    case Product
    case Note
    
    var rawValue: String {
        switch self {
        case .Task: return "Task"
        case .Product: return "Product"
        case .Note: return "Note"
        }
    }
}
