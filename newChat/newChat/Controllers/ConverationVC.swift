//
//  ConverationViewController.swift
//  newChat
//
//  Created by Марина on 17.10.2023.
//

import UIKit
import MessageKit

class ConverationVC: MessagesViewController {

    private var messages = [Message]()
    private let selfSender = Sender(senderId: "1",
                                    photoURL: "",
                                    displayName: "Marina")
    
    override func viewDidLoad() {
        super.viewDidLoad()
     
        
        messages.append(Message(sender: selfSender,
                                messageId: "1",
                                sentDate: Date(),
                                kind: .text("it works")))
        messages.append(Message(sender: selfSender,
                                messageId: "1",
                                sentDate: Date(),
                                kind: .text("it works yeeeeee")))
        view.backgroundColor = .white
//        title = "Conversations"
        setupDelegates()
    }
    private func setupDelegates() {
        messagesCollectionView.messagesDataSource = self
        messagesCollectionView.messagesLayoutDelegate = self
        messagesCollectionView.messagesDisplayDelegate = self
        
        messagesCollectionView.reloadData()
    }
}

extension ConverationVC: MessagesDataSource, MessagesLayoutDelegate, MessagesDisplayDelegate {
    var currentSender: MessageKit.SenderType {
        return selfSender
    }
    
    // 1 message for one section
    func messageForItem(at indexPath: IndexPath, in messagesCollectionView: MessageKit.MessagesCollectionView) -> MessageKit.MessageType {
        return messages[indexPath.section]
    }
    
    func numberOfSections(in messagesCollectionView: MessageKit.MessagesCollectionView) -> Int {
        messages.count
    }
    
    
    
}
