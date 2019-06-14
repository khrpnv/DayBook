//
//  MessagesContainer.swift
//  DayBook
//
//  Created by Илья on 6/14/19.
//  Copyright © 2019 Илья. All rights reserved.
//

import Foundation

class MessagesContainer{
    public static let instance = MessagesContainer()
    private var messages: [Message] = []
    private init(){}
    
    func addMessage(message: Message){
        messages.append(message)
    }
    
    func getMessages() -> [Message]{
        return messages
    }
    
    func setMessages(messages: [Message]){
        self.messages = messages
    }
}
