//
//  Note.swift
//  DayBook
//
//  Created by Илья on 6/13/19.
//  Copyright © 2019 Илья. All rights reserved.
//

import Foundation

struct Note {
    let title: String
    let content: String
    
    init(title: String, content: String) {
        self.title = title
        self.content = content
    }
}
