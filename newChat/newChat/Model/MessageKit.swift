//
//  MessageKit.swift
//  newChat
//
//  Created by Марина on 19.10.2023.
//

import Foundation
import MessageKit

struct Message: MessageType {
    var sender: MessageKit.SenderType
    
    var messageId: String
    
    var sentDate: Date
    
    var kind: MessageKit.MessageKind
}

struct Sender: SenderType {
    var senderId: String
    var photoURL: String
    var displayName: String
}
