//
//  Task.swift
//  DayBook
//
//  Created by Илья on 6/14/19.
//  Copyright © 2019 Илья. All rights reserved.
//

import Foundation

struct Task{
    let id: Int
    var taskText: String
    
    init(id: Int, task: String) {
        self.id = id
        self.taskText = task
    }
}
