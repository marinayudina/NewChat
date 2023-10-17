//
//  DatabaseManager.swift
//  newChat
//
//  Created by Марина on 17.10.2023.
//

import Foundation
import FirebaseFirestore

struct FStore {
    static let documentUsers = "Users"
    static let firstNameField = "firstName"
    static let lastNameField = "lastName"
    static let emailField = "emailAddress"
}

struct User {
    let firstName: String
    let lastName: String
    let emailAddress: String
//    let profilePicture
}
