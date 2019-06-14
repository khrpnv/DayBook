//
//  ChatViewController.swift
//  DayBook
//
//  Created by Илья on 6/10/19.
//  Copyright © 2019 Илья. All rights reserved.
//

import UIKit
import MessageKit
import InputBarAccessoryView
import LetterAvatarKit

class ChatViewController: MessagesViewController {
    
    private var messages: [Message] = []
    private var member: Member!
    private var chatService: ChatService!
    var taskToSend: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let userName = User.instance.getUserName()
        member = Member(name: userName, color: .random)
        setupChatUI()
        setDelegates()
        setObservers()
        initializeChatService()
        chatService.connect()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        messageInputBar.inputTextView.text = taskToSend
        messages = MessagesContainer.instance.getMessages()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        MessagesContainer.instance.setMessages(messages: messages)
        chatService.disconnect()
    }
    
    //MARK: - setup functions
    private func setupChatUI(){
        messageInputBar.delegate = self
        messageInputBar.inputTextView.tintColor = .primaryColor
        messageInputBar.sendButton.setImage(UIImage(named: "send"), for: .normal)
        messageInputBar.sendButton.title = ""
        messageInputBar.inputTextView.placeholder = "New Message"
        messagesCollectionView.backgroundColor = #colorLiteral(red: 0.9450980392, green: 0.9294117647, blue: 0.8980392157, alpha: 1)
    }
    
    private func setDelegates(){
        messagesCollectionView.messagesDataSource = self
        messagesCollectionView.messagesLayoutDelegate = self
        messageInputBar.delegate = self
        messagesCollectionView.messagesDisplayDelegate = self
    }
    
    private func initializeChatService(){
        chatService = ChatService(member: member, onRecievedMessage: {
            [weak self] message in
            self?.messages.append(message)
            self?.messagesCollectionView.reloadData()
            self?.messagesCollectionView.scrollToBottom(animated: true)
        })
    }
    
    private func setObservers(){
        NotificationCenter.default.addObserver(self, selector: #selector(getTaggedMessage), name: .TaggedMessage, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(serverError), name: .ServerError, object: nil)
    }
}

//MARK: - MessagesDataSource
extension ChatViewController: MessagesDataSource {
    func currentSender() -> SenderType {
        return Sender(id: member.name, displayName: member.name)
    }
    
    func numberOfSections(in messagesCollectionView: MessagesCollectionView) -> Int {
        return messages.count
    }
    
    func messageForItem(at indexPath: IndexPath, in messagesCollectionView: MessagesCollectionView) -> MessageType {
        return messages[indexPath.section]
    }
    
    func messageTopLabelHeight(for message: MessageType, at indexPath: IndexPath, in messagesCollectionView: MessagesCollectionView) -> CGFloat {
        return 12
    }
    
    func messageTopLabelAttributedText(for message: MessageType, at indexPath: IndexPath) -> NSAttributedString? {
        return NSAttributedString(string: message.sender.displayName, attributes: [.font: UIFont.systemFont(ofSize: 12)])
    }
}

//MARK: - MessagesLayoutDelegate
extension ChatViewController: MessagesLayoutDelegate {
    func heightForLocation(message: MessageType, at indexPath: IndexPath, with maxWidth: CGFloat, in messagesCollectionView: MessagesCollectionView) -> CGFloat {
        return 0
    }
}

//MARK: - MessagesDisplayDelegate
extension ChatViewController: MessagesDisplayDelegate {
    func configureAvatarView(_ avatarView: AvatarView, for message: MessageType, at indexPath: IndexPath, in messagesCollectionView: MessagesCollectionView) {
        let message = messages[indexPath.section]
        let color = message.member.color
        avatarView.backgroundColor = color
        avatarView.image = UIImage.makeLetterAvatar(withUsername: message.member.name)
    }
    
    func messageStyle(for message: MessageType, at indexPath: IndexPath, in messagesCollectionView: MessagesCollectionView) -> MessageStyle {
        if message.sender.displayName == self.member.name{
            return .bubbleTail(.bottomRight, .curved)
        } else {
            return .bubbleTail(.bottomLeft, .curved)
        }
    }
}

//MARK: - InputBarAccessoryViewDelegate
extension ChatViewController: InputBarAccessoryViewDelegate {
    func inputBar(_ inputBar: InputBarAccessoryView, didPressSendButtonWith text: String) {
        chatService.sendMessage(text)
        inputBar.inputTextView.text = ""
        self.messagesCollectionView.reloadData()
        self.messagesCollectionView.scrollToBottom(animated: true)
    }
}

//MARK: - Notifications
extension ChatViewController{
    @objc func getTaggedMessage(){
        let message = SentInfo.instance.getInfo()
        let user = SentInfo.instance.getSenderName()
        self.present(UIAlertController.SaveFromMessageActionSheet(message: message, sender: user), animated: true, completion: nil)
    }
    
    @objc func serverError(){
        self.present(UIAlertController.ServerError(), animated: true, completion: nil)
    }
}
