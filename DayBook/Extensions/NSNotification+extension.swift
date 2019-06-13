//
//  NSNotification+extension.swift
//  DayBook
//
//  Created by Илья on 6/11/19.
//  Copyright © 2019 Илья. All rights reserved.
//

import Foundation

extension NSNotification.Name{
    static let TaggedMessage = NSNotification.Name("TaggedMessage")
    static let AddTask = NSNotification.Name("AddTask")
    static let EditTask = NSNotification.Name("EditTask")
    static let AddProduct = NSNotification.Name("AddProduct")
    static let EditProduct = NSNotification.Name("EditProduct")
    static let DeleteNote = NSNotification.Name("DeleteNote")
    static let EditNote = NSNotification.Name("EditNote")
    static let AddNote = NSNotification.Name("AddNote")
    static let RefreshSum = NSNotification.Name("RefreshSum")
    static let AddBudgetInfo = NSNotification.Name("AddBudgetInfo")
}
