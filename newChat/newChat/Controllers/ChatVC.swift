//
//  ChatVC.swift
//  newChat
//
//  Created by Марина on 13.10.2023.
//

import UIKit
import FirebaseAuth
class ChatVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "log out", style: .plain, target: self, action: #selector(tapButton))
    }
    
    @objc private func tapButton() {
        let firebaseAuth = Auth.auth()
        do {
          try firebaseAuth.signOut()
            navigationController?.popToRootViewController(animated: true)
            print("log out")
        } catch let signOutError as NSError {
          print("Error signing out: %@", signOutError)
        }
//        let vc = WelcomeVC()
//        present(vc, animated: true)
//        navigationController?.popToRootViewController(animated: true)
        print("log out")
    }
 

}
