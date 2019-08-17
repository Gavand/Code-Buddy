//
//  SignUpViewController.swift
//  CodeBuddy
//
//  Created by Gavin Andrews on 6/14/18.
//  Copyright © 2018 Gavin Andrews. All rights reserved.
//

import UIKit
import FBSDKLoginKit
import FacebookLogin
import FacebookCore
import FirebaseAuth
import FirebaseDatabase
import FirebaseStorage
import JGProgressHUD

class SignUpViewController: UIViewController {
    @IBOutlet weak var meImage: UIImageView!
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var signupButton: UIButton!
    
    var pickedImage: UIImage!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.hideKeyboardWhenTappedAround()
        
        usernameTextField.backgroundColor = UIColor.clear
        usernameTextField.attributedPlaceholder = NSAttributedString(string: usernameTextField.placeholder!, attributes: [NSAttributedStringKey.foregroundColor: UIColor(red: (253/255), green: (178/255), blue: (43/255), alpha: 1)])
        let bottomLayerUsername = CALayer()
        bottomLayerUsername.frame = CGRect(x: 0, y: 29, width: 1000, height: 0.6)
        bottomLayerUsername.backgroundColor = UIColor(red: (253/255), green: (178/255), blue: (43/255), alpha: 1).cgColor
        usernameTextField.layer.addSublayer(bottomLayerUsername)
        
        emailTextField.backgroundColor = UIColor.clear
        emailTextField.attributedPlaceholder = NSAttributedString(string: emailTextField.placeholder!, attributes: [NSAttributedStringKey.foregroundColor: UIColor(red: (253/255), green: (178/255), blue: (43/255), alpha: 1)])
        let bottomLayerEmail = CALayer()
        bottomLayerEmail.frame = CGRect(x: 0, y: 29, width: 1000, height: 0.6)
        bottomLayerEmail.backgroundColor = UIColor(red: (253/255), green: (178/255), blue: (43/255), alpha: 1).cgColor
        emailTextField.layer.addSublayer(bottomLayerEmail)
        
        passwordTextField.backgroundColor = UIColor.clear
        passwordTextField.attributedPlaceholder = NSAttributedString(string: passwordTextField.placeholder!, attributes: [NSAttributedStringKey.foregroundColor: UIColor(red: (253/255), green: (178/255), blue: (43/255), alpha: 1)])
        let bottomLayerPassword = CALayer()
        bottomLayerPassword.frame = CGRect(x: 0, y: 29, width: 1000, height: 0.6)
        bottomLayerPassword.backgroundColor = UIColor(red: (253/255), green: (178/255), blue: (43/255), alpha: 1).cgColor
        passwordTextField.layer.addSublayer(bottomLayerPassword)
        
        signupButton.layer.cornerRadius = 10
        signupButton.clipsToBounds = true
        
        //        let loginButton = LoginButton(readPermissions: [ .publicProfile ])
//        let loginButton = LoginButton(readPermissions: [ .publicProfile, .email, .userFriends ])
//
////        loginButton.center = view.center
//        loginButton.frame = CGRect(x: 16, y: 625, width: view.frame.width - 32, height: 44)
//        loginButton.layer.cornerRadius = 10
//        loginButton.clipsToBounds = true
        
        if AccessToken.current != nil {
        }
        
//        view.addSubview(loginButton)
        
        meImage.layer.cornerRadius = 60.5
        meImage.clipsToBounds = true
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(self.handleSelectMeImageView))
        meImage.addGestureRecognizer(tapGesture)
        meImage.isUserInteractionEnabled = true
        signupButton.isEnabled = false
        
        handleTextField()
    }
    
    override func touchesBegan(_ touhes: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
    
    func handleTextField() {
        usernameTextField.addTarget(self, action: #selector(self.textFieldDidChange), for: UIControlEvents.editingChanged)
        emailTextField.addTarget(self, action: #selector(self.textFieldDidChange), for: UIControlEvents.editingChanged)
        passwordTextField.addTarget(self, action: #selector(self.textFieldDidChange), for: UIControlEvents.editingChanged)
    }
    
    @objc func textFieldDidChange() {
        guard let username = usernameTextField.text, !username.isEmpty, let email = emailTextField.text, !email.isEmpty,
            let password = passwordTextField.text, !password.isEmpty else {
                signupButton.setTitleColor(UIColor.lightText, for: UIControlState.normal)
                
                return
        }
        signupButton.setTitleColor(UIColor.white, for: UIControlState.normal)
        signupButton.isEnabled = true
    }
    
    @objc func handleSelectMeImageView() {
        let pickerController = UIImagePickerController()
        pickerController.delegate = self
        present(pickerController, animated: true, completion: nil)
    }
    
    @IBAction func dismiss_onClick(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func signupButton_TouchUpInside(_ sender: Any) {
        view.endEditing(true)
        let hud = JGProgressHUD(style: .dark)
        hud.textLabel.text = "Loading"
        hud.show(in: self.view)
        hud.dismiss(afterDelay: 3.0)
        if let profileImage = self.pickedImage, let dataImage = UIImageJPEGRepresentation(profileImage, 0.1) {
            AuthService.signUp(username: usernameTextField.text!, email: emailTextField.text!, password: passwordTextField.text!, dataImage: dataImage , onSuccess: {
                hud.textLabel.text = "Success"
                hud.indicatorView = JGProgressHUDSuccessIndicatorView()
                hud.show(in: self.view)
                hud.dismiss(afterDelay: 3.0)
                self.performSegue(withIdentifier: "SignupToTabbar", sender: nil)
            }, onError: { (errorString) in
                hud.textLabel.text = errorString
                hud.indicatorView = JGProgressHUDErrorIndicatorView()
                hud.show(in: self.view)
                hud.dismiss(afterDelay: 3.0)
            })
        } else {
            hud.textLabel.text = "Profile image can't be empty"
            hud.indicatorView = JGProgressHUDErrorIndicatorView()
            hud.show(in: self.view)
            hud.dismiss(afterDelay: 3.0)
            
        }
    }
}


extension SignUpViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        print("Finished")
        if let image = info["UIImagePickerControllerOriginalImage"] as? UIImage {
            pickedImage = image
            meImage.image = image
        }
        dismiss(animated: true, completion: nil)
    }
}
