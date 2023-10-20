//
//  ChatVC_Cell.swift
//  newChat
//
//  Created by Марина on 17.10.2023.
//

import UIKit

class ChatVCCell: UITableViewCell {
    static let idChatCell = "idChatCell"
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
//        backgroundColor = .green
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
