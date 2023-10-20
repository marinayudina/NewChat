//
//  ChatVC.swift
//  newChat
//
//  Created by Марина on 13.10.2023.
//

import UIKit
import FirebaseAuth
import JGProgressHUD

class ChatVC: UIViewController {
    
    private let spinner = JGProgressHUD(style: .dark)

    private let chatTable: UITableView = {
        let tableV = UITableView()
        tableV.isHidden = true
//        tableV.backgroundColor = .red
        tableV.translatesAutoresizingMaskIntoConstraints = false
        tableV.register(ChatVCCell.self, forCellReuseIdentifier: ChatVCCell.idChatCell)
        return tableV
    }()
    
    private let noConversationsLabel: UILabel = {
        let label = UILabel()
        label.text = "No conversations yet"
        label.textAlignment = .center
        label.textColor = .gray
        label.isHidden = true
        label.font = .systemFont(ofSize: 21, weight: .medium)
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Log out",
                                                                 style: .plain,
                                                                 target: self,
                                                                 action: #selector(tapButton))
//        self.navigationItem.leftBarButtonItem = UIBarButtonItem(title: "New Chat",
//                                                                style: .plain,
//                                                                target: self,
//                                                                action: #selector(NewChatTapped))
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .compose, target: self, action: #selector(NewChatTapped))
        setUpView()
    }
    
    private func setUpView() {
        view.addSubview(chatTable)
        
        setUpTableView()
        setConstraints()
        
        title = "Chats"
    }
    
    private func setUpTableView() {
        chatTable.delegate = self
        chatTable.dataSource = self
        fetchConversation()
    }
    
    private func fetchConversation() {
        chatTable.isHidden = false
    }
    
    @objc private func NewChatTapped() {
        let vc = UINavigationController(rootViewController: NewConversationVC())
        present(vc, animated: true)
    }
    
    @objc private func tapButton() {
        let firebaseAuth = Auth.auth()
        do {
          try firebaseAuth.signOut()
            let welcomeVc = UINavigationController(rootViewController: WelcomeVC())
            welcomeVc.modalPresentationStyle = .fullScreen
            present(welcomeVc, animated: true)
            
        } catch let signOutError as NSError {
          print("Error signing out: %@", signOutError)
        }
    }
}

extension ChatVC {
    private func setConstraints() {
        NSLayoutConstraint.activate([
            chatTable.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10),
            chatTable.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            chatTable.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            chatTable.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20)
        ])
    }
}

extension ChatVC: UITableViewDelegate {
    
}

extension ChatVC: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = chatTable.dequeueReusableCell(withIdentifier: ChatVCCell.idChatCell, for: indexPath) as? ChatVCCell else {return UITableViewCell()}
        cell.textLabel?.text = "hello world"
        cell.accessoryType = .disclosureIndicator
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        chatTable.deselectRow(at: indexPath, animated: true)
        
        let vc = ConverationVC()
        vc.title = "Marina"
        navigationController?.pushViewController(vc, animated: true)
    }
}
