//
//  ChatService.swift
//  DayBook
//
//  Created by Илья on 6/10/19.
//  Copyright © 2019 Илья. All rights reserved.
//

import Foundation
import Scaledrone

class ChatService {
    
    private let scaledrone: Scaledrone
    private let messageCallback: (Message)-> Void
    private var room: ScaledroneRoom?
    
    init(member: Member, onRecievedMessage: @escaping (Message)-> Void) {
        self.messageCallback = onRecievedMessage
        self.scaledrone = Scaledrone(
            channelID: "BAdCk6REgiSGKz7s",
            data: member.toJSON)
        scaledrone.delegate = self
    }
    
    func connect() {
        scaledrone.connect()
    }
    
    func disconnect() {
        scaledrone.disconnect()
    }
    
    func sendMessage(_ message: String) {
        room?.publish(message: message)
    }
}

//MARK: - ScaledroneDelegate
extension ChatService: ScaledroneDelegate {
    func scaledroneDidConnect(scaledrone: Scaledrone, error: Error?) {
        print("Connected to Scaledrone")
        room = scaledrone.subscribe(roomName: "observable-Chat")
        room?.delegate = self
    }
    
    func scaledroneDidReceiveError(scaledrone: Scaledrone, error: Error?) {
        print("Scaledrone error", error ?? "")
    }
    
    func scaledroneDidDisconnect(scaledrone: Scaledrone, error: Error?) {
        print("Scaledrone disconnected", error ?? "")
    }
}

//MARK: - ScaledroneRoomDelegate
extension ChatService: ScaledroneRoomDelegate {
    func scaledroneRoomDidConnect(room: ScaledroneRoom, error: Error?) {
        print("Connected to room!")
    }
    func scaledroneRoomDidReceiveMessage(room: ScaledroneRoom, message: Any, member: ScaledroneMember?) {
        guard let text = message as? String, let memberData = member?.clientData, let member = Member(fromJSON: memberData) else {
            NotificationCenter.default.post(name: .ServerError, object: nil)
            return
        }
        let message = Message(
            member: member,
            text: text,
            messageId: UUID().uuidString)
        messageCallback(message)
        if member.name != User.instance.getUserName(){
            if MessagesInspector.instance.messageContainTag(message: text){
                SentInfo.instance.setInfo(currentInfo: text, senderName: member.name)
                NotificationCenter.default.post(name: .TaggedMessage, object: nil)
            }
        }
    }
}
