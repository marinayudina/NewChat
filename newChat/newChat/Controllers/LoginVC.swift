//
//  LoginVC.swift
//  newChat
//
//  Created by Марина on 13.10.2023.
//

import UIKit
import FirebaseAuth
import JGProgressHUD

class LogInVC: UIViewController {
    
    private let spinner = JGProgressHUD(style: .dark)

    private lazy var emailTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Email"
        textField.text = "0518204@mail.ru"
        textField.font = .systemFont(ofSize: 25)
        textField.backgroundColor = .white
        textField.layer.cornerRadius = 10
        textField.textAlignment = .center
        textField.clipsToBounds = true
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.autocapitalizationType = .none
        textField.returnKeyType = .continue
        textField.text = "0518204@mail.ru"
        return textField
    }()
    
    private lazy var passwordTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Password"
        textField.text = "mari22"
        textField.font = .systemFont(ofSize: 25)
        textField.backgroundColor = .white
        textField.layer.cornerRadius = 10
        textField.textAlignment = .center
        textField.clipsToBounds = true
        textField.isSecureTextEntry = true
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.returnKeyType = .done
        textField.textContentType = .oneTimeCode
        textField.autocorrectionType = .no
        textField.text = "mari22"
        return textField
    }()
    
    
    private lazy var logButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Log in", for: .normal)
        button.tintColor = .white
        button.backgroundColor = .clear
        button.titleLabel?.font = .systemFont(ofSize: 30)
        button.addTarget(self, action: #selector(logButtonTapped), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

//    var isFirstLayout: Bool = true
//    override func viewDidLayoutSubviews() {
//        super.viewDidLayoutSubviews()
//        if isFirstLayout {
//            defer { isFirstLayout = false }
//            emailTextField.becomeFirstResponder()
//        }
//    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        emailTextField.becomeFirstResponder()
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .systemCyan
        setupView()
        setConstraints()
        
//        navigationItem.backButtonTitle = ""

        emailTextField.delegate = self
        passwordTextField.delegate = self
        
//        emailTextField.becomeFirstResponder()

    }
    private func   setupView() {
        view.addSubview(emailTextField)
        
        view.addSubview(passwordTextField)
        view.addSubview(logButton)
    }
    
    private func showAlert(_ e: String) {
        let alert = UIAlertController(title: e, message: nil, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: NSLocalizedString("OK", comment: "Default action"), style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    @objc private func logButtonTapped() {
        emailTextField.resignFirstResponder()
        passwordTextField.resignFirstResponder()
        
        guard let email = emailTextField.text,
              let password = passwordTextField.text,
              !email.isEmpty, !password.isEmpty else {
            showAlert("Fill all fields")
                return
        }
       // login
        
        spinner.show(in: view)
        
        Auth.auth().signIn(withEmail: email, password: password) { [weak self] authResult, error in
            
            guard let self = self else { return }
            
            DispatchQueue.main.async {
                self.spinner.dismiss(animated: true)
            }
            
            

                if let error = error as NSError? {
                    if let authError = AuthErrorCode.Code(rawValue: error.code) {
                        switch authError {
                        case .invalidEmail:
                            self.showAlert("Email is invalid.")
                        case .operationNotAllowed:
                            self.showAlert("not allowed")
                        case .userDisabled:
                            self.showAlert("User's account is disabled.")
                        case .userNotFound:
                            self.showAlert("User's account was not found.")
                        case .wrongPassword:
                            self.showAlert("Wrong password. Try again")
                        default:
                            self.showAlert("An unknowm error")
                        }
                    }
            } else {
                
                UserDefaults.standard.set(email, forKey: "email")
                
                let chatVC = TabBarVC()
                chatVC.modalPresentationStyle = .fullScreen
                self.present(chatVC, animated: true)
            }
        }
    }
  
    }

extension LogInVC {
    private func setConstraints() {
        NSLayoutConstraint.activate([
            
            emailTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            emailTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            emailTextField.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            emailTextField.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.06),


            passwordTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            passwordTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            passwordTextField.topAnchor.constraint(equalTo: emailTextField.bottomAnchor, constant: 10),
            passwordTextField.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.06),
//            passwordTextField.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.8)
            
            logButton.topAnchor.constraint(equalTo: passwordTextField.bottomAnchor, constant: 10),
            logButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            logButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),

        ])
    }
}

extension LogInVC: UITextFieldDelegate {
    //when user tap continue/return button
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == emailTextField {
            passwordTextField.becomeFirstResponder()
        } else if textField == passwordTextField {
            logButtonTapped()
        }
        return true
    }
}
