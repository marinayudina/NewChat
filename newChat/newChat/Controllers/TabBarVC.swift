//
//  TabBarVCViewController.swift
//  newChat
//
//  Created by Марина on 17.10.2023.
//

import UIKit

class TabBarVC: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        configureTabs()

    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.isNavigationBarHidden = true
    }
    private func configureTabs() {
        let vc1 = ChatVC()
        let vc2 = ProfileVC()
        
        
        vc1.tabBarItem.image = UIImage(systemName: "message")
        vc2.tabBarItem.image = UIImage(systemName: "person")
        
        vc1.tabBarItem.title = "Chats"
        vc2.title = "Profile"
        
        let nav1 = UINavigationController(rootViewController: vc1)
        let nav2 = UINavigationController(rootViewController: vc2)
        
        setViewControllers([nav1, nav2], animated: false)
        
//        navigationController?.isNavigationBarHidden = true
    }


}
