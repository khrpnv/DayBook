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
    
    static func AddTaskAlertWindow() -> UIAlertController {
        let alertController = UIAlertController(title: "Add new task", message: nil, preferredStyle: .alert)
        let confirmAction = UIAlertAction(title: "Add", style: .default) { (_) in
            if let txtField = alertController.textFields?.first, let text = txtField.text {
                TODOManager.instance.addTask(text: text)
                NotificationCenter.default.post(name: .AddTask, object: nil)
            }
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel) { (_) in }
        alertController.addTextField { (textField) in
            textField.placeholder = "Task"
        }
        alertController.addAction(confirmAction)
        alertController.addAction(cancelAction)
        return alertController
    }
}
