//
//  DatabaseManager.swift
//  newChat
//
//  Created by Марина on 17.10.2023.
//

import Foundation
import FirebaseFirestore

final class DatabaseManager {
    static let shared = DatabaseManager()
    
    let db = Firestore.firestore()
    
    public func addUser(with user: User, completion: @escaping(Bool) -> Void) {
        db.collection(FStore.documentUsers).document(user.emailAddress).setData([
            FStore.firstNameField: user.firstName,
            FStore.lastNameField: user.lastName]) { error in
                guard error == nil else {
                    print("failed to write to database")
                    completion(false)
                    return
                }
                completion(true)
                
                //        print(db)
            }
    }
}

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
    var profilePictureURL: String {
        return "\(emailAddress)_profile_picture.png"
    }
}

