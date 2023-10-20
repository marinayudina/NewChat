//
//  RegisterVC.swift
//  newChat
//
//  Created by Марина on 13.10.2023.
//

import UIKit
import FirebaseAuth
import FirebaseFirestore
import JGProgressHUD

class RegisterVC: UIViewController {
    
    let db = Firestore.firestore()
    
    private let spinner = JGProgressHUD(style: .dark)
    
    private let userImage: UIImageView = {
        let imageView = UIImageView(image: UIImage(systemName: "person.circle"))
        imageView.contentMode = .scaleAspectFit
        imageView.tintColor = .gray
        imageView.layer.masksToBounds = true
        imageView.layer.borderWidth = 2
        imageView.layer.borderColor = UIColor.lightGray.cgColor
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private lazy var emailTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Email"
        textField.font = .systemFont(ofSize: 25)
        textField.backgroundColor = .white
//        textField.text = "0518204@mail.ru"
        textField.layer.cornerRadius = 10
        textField.textAlignment = .center
        textField.clipsToBounds = true
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.autocapitalizationType = .none
        textField.returnKeyType = .continue
        return textField
    }()
    private lazy var firstNameTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "First Name"
        textField.font = .systemFont(ofSize: 25)
        textField.backgroundColor = .white
        textField.layer.cornerRadius = 10
        textField.textAlignment = .center
        textField.clipsToBounds = true
//        textField.text = "marina"
        textField.translatesAutoresizingMaskIntoConstraints = false
//        textField.autocapitalizationType = .none
        textField.returnKeyType = .continue
        return textField
    }()
    private lazy var lastNameTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Last Name"
        textField.font = .systemFont(ofSize: 25)
        textField.backgroundColor = .white
        textField.layer.cornerRadius = 10
        textField.textAlignment = .center
        textField.clipsToBounds = true
//        textField.text = "yudina"
        textField.translatesAutoresizingMaskIntoConstraints = false
//        textField.autocapitalizationType = .none
        textField.returnKeyType = .continue
        return textField
    }()
    
    let mainStack = UIStackView(axis: .vertical,
                                spacing: 2,
                                alignment: .center,
                                distribution: .equalSpacing)
    
    private lazy var passwordTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Password"
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
//        textField.text = "mari22"
        return textField
    }()
    

    
    private lazy var registerButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Register", for: .normal)
        button.tintColor = .BrandBlue
        button.backgroundColor = .clear
        button.titleLabel?.font = .systemFont(ofSize: 30)
        button.addTarget(self, action: #selector(registerButtonTapped), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

//    override func viewDidAppear(_ animated: Bool) {
//        super.viewDidAppear(animated)
//        emailTextField.becomeFirstResponder()
//    }
//    var isFirstLayout: Bool = true
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
//        if isFirstLayout {
//            defer { isFirstLayout = false }
//            emailTextField.becomeFirstResponder()
//        }
        userImage.layer.cornerRadius = userImage.frame.width / 2
    }
    
//    override func viewDidAppear(_ animated: Bool) {
//        super.viewDidAppear(animated)
//        emailTextField.becomeFirstResponder()
//    }
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .BrandLightBlue
        setupView()
        setConstraints()
        setMainStack()
        setGesture()
        
//        mainStack.backgroundColor = .systemPink
//        navigationItem.backButtonTitle = ""
    }
    
    private func setGesture() {
        userImage.isUserInteractionEnabled = true
        let gesture = UITapGestureRecognizer(target: self,
                                             action: #selector(changePhotoTap))
        userImage.addGestureRecognizer(gesture)
    }
    
    private func   setupView() {
        view.addSubview(userImage)
     
        view.addSubview(registerButton)
        
        view.addSubview(mainStack)
        mainStack.addArrangedSubviews([emailTextField, firstNameTextField, lastNameTextField, passwordTextField])
        
        emailTextField.delegate = self
        passwordTextField.delegate = self
        
//        emailTextField.becomeFirstResponder()
    }
    
    private func showAlert(_ e: String) {
        let alert = UIAlertController(title: e, message: nil, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: NSLocalizedString("OK", comment: "Default action"), style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    @objc private func registerButtonTapped() {
        emailTextField.resignFirstResponder()
        passwordTextField.resignFirstResponder()
        firstNameTextField.resignFirstResponder()
        lastNameTextField.resignFirstResponder()
        
        guard let email = emailTextField.text,
              let password = passwordTextField.text,
              let firstName = firstNameTextField.text,
              let lastName = lastNameTextField.text,
              !email.isEmpty, !password.isEmpty,
              !firstName.isEmpty, !lastName.isEmpty
        else {
            showAlert("Fill all fields")
            return
        }
        
        //Firebase Registration
        
        DispatchQueue.main.async {
            self.spinner.dismiss(animated: true)
        }
        
        Auth.auth().createUser(withEmail: email, password: password) { [weak self] authResult, error in
            guard let self = self else { return }
            
            if let error = error as NSError?{
//                 authResult == nil {
//                print(result)
                if let authError = AuthErrorCode.Code(rawValue: error.code) {
                    switch authError {
                    case .invalidEmail:
                        self.showAlert("Email is invalid.")
                    case .emailAlreadyInUse:
                        self.showAlert("Email used to attempt sign up already exists")
                    case .weakPassword:
                        self.showAlert(error.userInfo[NSLocalizedFailureReasonErrorKey] as! String)
                    default:
                        self.showAlert("An unknowm error")
                    }
                }
            }
            else {
                self.db.collection(FStore.documentUsers).addDocument(data:
                                                                    [FStore.emailField : email,
                                                                     FStore.firstNameField: firstName,
                                                                     FStore.lastNameField: lastName,
                                                                     ])
                //тут tabbar
                let chatVC = TabBarVC()
                chatVC.modalPresentationStyle = .fullScreen
                self.present(chatVC, animated: true)
            }
        }
    }

    @objc private func changePhotoTap() {
        presentPhotoActionSheet()
    }

//    @objc private func registerButtonTapped(_ sender: UIButton) {
//        view.endEditing(true)
//        if let email = emailTextField.text,
//           let password = passwordTextField.text {
//            if email.isEmpty == true {
//                showAlert("Fill email field")
//                return
//            }
//            Auth.auth().createUser(withEmail: email, password: password) { [ weak self] authResult, error in
//                guard let self = self else { return }
//                if let error = error {
//                    if let error = error as NSError? {
//                        if let authError = AuthErrorCode.Code(rawValue: error.code) {
//                            switch authError {
//                            case .invalidEmail:
//                                self.showAlert("Email is invalid.")
//                            case .emailAlreadyInUse:
//                                self.showAlert("Email used to attempt sign up already exists")
//                            case .weakPassword:
//                                self.showAlert(error.userInfo[NSLocalizedFailureReasonErrorKey] as! String)
//                            default:
//                                self.showAlert("An unknowm error")
//                            }
//                        }
//                    }
//
//                } else {
//                    let chatVC = ChatVC()
//                    navigationController?.pushViewController(chatVC, animated: true)
//                }
//            }
//        }
//
//
//    }
}

extension RegisterVC {
    func setMainStack() {
        mainStack.arrangedSubviews.forEach {
            NSLayoutConstraint.activate([
                $0.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.06),
                $0.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.85)
            ])
        }
    }
    private func setConstraints() {
        
        NSLayoutConstraint.activate([
            
            userImage.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            userImage.heightAnchor.constraint(equalToConstant: 140),
            userImage.widthAnchor.constraint(equalToConstant: 145),
            userImage.centerXAnchor.constraint(equalTo: view.centerXAnchor),

            
            mainStack.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            mainStack.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
            mainStack.topAnchor.constraint(equalTo: userImage.bottomAnchor, constant: 20),
            mainStack.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.3),
   
            
            
            registerButton.topAnchor.constraint(equalTo: mainStack.bottomAnchor, constant: 10),
            registerButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            registerButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),

        ])
    }
}
extension RegisterVC: UITextFieldDelegate {
    //when user tap continue/return button
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == emailTextField {
            passwordTextField.becomeFirstResponder()
        } else if textField == passwordTextField {
            registerButtonTapped()
        }
        return true
    }
}

extension RegisterVC: UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    func presentPhotoActionSheet() {
        let actionSheet = UIAlertController(title: "Profile Picture",
                                            message: "How would you like to select a picture?",
                                            preferredStyle: .actionSheet)
        
        actionSheet.addAction(UIAlertAction(title: "Cancel",
                                            style: .cancel))
        actionSheet.addAction(UIAlertAction(title: "Take photo",
                                            style: .default, handler: { [weak self] _  in
            self?.presentCamera()
            
        }))
        actionSheet.addAction(UIAlertAction(title: "Choose photo",
                                            style: .default, handler: { [weak self] _ in
            self?.presentPhotoPicker()
            
        }))
        present(actionSheet, animated: true)
    }
    
    func presentCamera() {
        let vc = UIImagePickerController()
        vc.sourceType = .camera
        vc.delegate = self
        vc.allowsEditing = true
        present(vc, animated: true)
    }
    
    func presentPhotoPicker() {
        let vc = UIImagePickerController()
        vc.sourceType = .photoLibrary
        vc.delegate = self
        vc.allowsEditing = true
        present(vc, animated: true)
    }
    
    
    //when user takes or select a photo
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
//        print(info)
        picker.dismiss(animated: true)
        guard let selectedImage = info[UIImagePickerController.InfoKey.editedImage] as? UIImage else { return }
        DispatchQueue.main.async {
            self.userImage.image = selectedImage
        }
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true)
    }
}
