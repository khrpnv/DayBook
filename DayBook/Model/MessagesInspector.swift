//
//  MessagesInspector.swift
//  DayBook
//
//  Created by Илья on 6/11/19.
//  Copyright © 2019 Илья. All rights reserved.
//

import Foundation

class MessagesInspector{
    public static let instance = MessagesInspector()
    private init(){}
    public let tags = ["#TODO", "#Buy", "#Note"]
    
    private func removeTag(message: String, tag: String) -> String{
        let tagLength = tag.count + 2
        let index = message.index(message.startIndex, offsetBy: tagLength)
        return String(message.suffix(from: index))
    }
    
    public func inspectMessages(message: String){
        let tag = getTag(message: message)
        switch tag {
        case "#TODO":
            TODOManager.instance.addTask(text: removeTag(message: message, tag: tag))
            NotificationCenter.default.post(name: .AddTask, object: nil)
        case "#Note":
            NotesManager.instance.saveNoteFromMessage(content: removeTag(message: message, tag: tag))
            NotificationCenter.default.post(name: .AddNote, object: nil)
        case "#Buy":
            ShopListManager.instance.addProduct(product: removeTag(message: message, tag: tag))
            NotificationCenter.default.post(name: .AddProduct, object: nil)
        default:
            print("No such tag")
        }
    }
    
    public func messageContainTag(message: String) -> Bool{
        let currentTag = message.split(separator: ":")[0]
        var result = false
        for tag in tags{
            if tag == currentTag{
                result = true
            }
        }
        return result
    }
    
    public func getTag(message: String) -> String{
        return String(message.split(separator: ":")[0])
    }
}
