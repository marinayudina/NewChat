//
//  ViewController.swift
//  newChat
//
//  Created by Марина on 13.10.2023.
//

import UIKit
import FirebaseAuth

class WelcomeVC: UIViewController {

    
    private let nameLabel: UILabel = {
        let label = UILabel()
        label.text = "NewChat"
        label.textColor = .BrandBlue
        label.font = .systemFont(ofSize: 50)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var registerButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Register", for: .normal)
        button.tintColor = .BrandBlue
        button.backgroundColor = .BrandLightBlue
        button.titleLabel?.font = .systemFont(ofSize: 30)
        button.addTarget(self, action: #selector(registerButtonTapped), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    private lazy var logButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Log in", for: .normal)
        button.tintColor = .white
        button.backgroundColor = .systemTeal
        button.titleLabel?.font = .systemFont(ofSize: 30)
        button.addTarget(self, action: #selector(logButtonTapped), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
//        validateAuth()
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        setupView()
        setConstraints()
        
        navigationItem.backButtonTitle = ""
        navigationController?.navigationBar.tintColor = .black
        
    }
//    private func validateAuth() {
//        if FirebaseAuth.Auth.auth().currentUser != nil {
//            let vc = ChatVC()
//            vc.modalPresentationStyle = .fullScreen
//            navigationController?.pushViewController(vc, animated: true)
//
//        }
//    }
    
    private func setupView() {
        view.addSubview(nameLabel)
        view.addSubview(logButton)
        view.addSubview(registerButton)
    }
    
    @objc private func registerButtonTapped() {
        let registerVC = RegisterVC()
        navigationController?.pushViewController(registerVC, animated: true)
    }
    
    @objc private func logButtonTapped() {
        let logInVC = LogInVC()
        navigationController?.pushViewController(logInVC, animated: true)
    }
}
extension WelcomeVC {
    private func setConstraints() {
        NSLayoutConstraint.activate([
            nameLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            nameLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            
            logButton.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            logButton.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            logButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            logButton.heightAnchor.constraint(equalToConstant: 50),
            
            registerButton.bottomAnchor.constraint(equalTo: logButton.topAnchor, constant: -10),
            registerButton.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            registerButton.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            registerButton.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
}

