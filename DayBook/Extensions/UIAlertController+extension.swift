//
//  UIAlertController+extension.swift
//  DayBook
//
//  Created by Илья on 6/11/19.
//  Copyright © 2019 Илья. All rights reserved.
//

import Foundation
import UIKit

extension UIAlertController{
    static func SaveFromMessageActionSheet(message: String, sender: String) -> UIAlertController {
        let tag = MessagesInspector.instance.getTag(message: message)
        let alertMessage = "\(sender) has just sent you \(tag).\n\(message)\n Would you like to save it?"
        let optionMenu = UIAlertController(title: nil, message: alertMessage, preferredStyle: .actionSheet)
        let dismissAction = UIAlertAction(title: "Dismiss", style: .cancel, handler: nil)
        let saveAction = UIAlertAction(title: "Save", style: .default) { (action) in
            MessagesInspector.instance.inspectMessages(message: message)
        }
        optionMenu.addAction(dismissAction)
        optionMenu.addAction(saveAction)
        return optionMenu
    }
    
    static func AddTaskAlertWindow(tag: Tag) -> UIAlertController {
        let alertController = UIAlertController(title: "Add \(tag.rawValue.lowercased())", message: nil, preferredStyle: .alert)
        let confirmAction = UIAlertAction(title: "Add", style: .default) { (_) in
            if let txtField = alertController.textFields?.first, let text = txtField.text {
                if tag == .Task{
                    TODOManager.instance.addTask(text: text)
                    NotificationCenter.default.post(name: .AddTask, object: nil)
                } else if tag == .Product{
                    ShopListManager.instance.addProduct(product: text)
                    NotificationCenter.default.post(name: .AddProduct, object: nil)
                }
            }
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel) { (_) in }
        alertController.addTextField { (textField) in
            textField.placeholder = tag.rawValue
        }
        alertController.addAction(confirmAction)
        alertController.addAction(cancelAction)
        return alertController
    }
    
    static func EditTaskAlertWindow(index: Int, oldValue: String, tag: Tag) -> UIAlertController {
        let alertController = UIAlertController(title: "Edit \(tag.rawValue.lowercased())", message: nil, preferredStyle: .alert)
        let confirmAction = UIAlertAction(title: "Edit", style: .default) { (_) in
            if let txtField = alertController.textFields?.first, let text = txtField.text {
                if tag == .Task{
                    TODOManager.instance.editTask(at: index, for: text)
                    NotificationCenter.default.post(name: .EditTask, object: nil)
                } else if tag == .Product{
                    ShopListManager.instance.editProduct(at: index, newValue: text)
                    NotificationCenter.default.post(name: .EditProduct, object: nil)
                }
            }
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel) { (_) in }
        alertController.addTextField { (textField) in
            textField.text = oldValue
        }
        alertController.addAction(confirmAction)
        alertController.addAction(cancelAction)
        return alertController
    }
    
    static func NoteSaved() -> UIAlertController{
        let alertController = UIAlertController(title: "Your note was saved successfully.", message: nil, preferredStyle: .alert)
        let confirmAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
        alertController.addAction(confirmAction)
        return alertController
    }
    
    static func ReloadData() -> UIAlertController{
        let alertController = UIAlertController(title: "Enter your start amount of money", message: nil, preferredStyle: .alert)
        let confirmAction = UIAlertAction(title: "Add", style: .default) { (_) in
            if let txtField = alertController.textFields?.first, let text = txtField.text {
                BudgetManager.instance.setStartSum(value: text.toDouble() ?? 1250.0)
                BudgetManager.instance.setCurrentSum()
                BudgetManager.instance.refreshData()
                NotificationCenter.default.post(name: .RefreshSum, object: nil)
            }
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel) { (_) in }
        alertController.addTextField { (textField) in
            textField.placeholder = "Start sum"
        }
        alertController.addAction(confirmAction)
        alertController.addAction(cancelAction)
        return alertController
    }
    
    static func AddBudgetData() -> UIAlertController{
        var data: BudgetData = BudgetData()
        let alertController = UIAlertController(title: "Enter budget data", message: nil, preferredStyle: .alert)
        let confirmAction = UIAlertAction(title: "Add", style: .default) { (_) in
            if let sumField = alertController.textFields?[0], let textSum = sumField.text {
                let sign = String(textSum.prefix(1))
                let currentSum = textSum.toDouble() ?? 0
                if sign == "-"{
                    data.lose = true
                    data.sum = currentSum*(-1)
                } else {
                    data.lose = false
                    data.sum = currentSum
                }
            }
            if let commentField = alertController.textFields?[1], let textComment = commentField.text {
                data.comment = textComment
            }
            BudgetManager.instance.addData(data: data)
            NotificationCenter.default.post(name: .AddBudgetInfo, object: nil)
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel) { (_) in }
        alertController.addTextField { (sumField) in
            sumField.placeholder = "Sum"
        }
        alertController.addTextField { (commentField) in
            commentField.placeholder = "Comment"
        }
        alertController.addAction(confirmAction)
        alertController.addAction(cancelAction)
        return alertController
    }
    
    static func ServerError() -> UIAlertController{
        let alertController = UIAlertController(title: "Server Error", message: "Something went wrong on server side. Please, restart the app.", preferredStyle: .alert)
        let confirmAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
        alertController.addAction(confirmAction)
        return alertController
    }
}
