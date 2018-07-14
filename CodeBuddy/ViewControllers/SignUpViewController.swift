//
//  SignUpViewController.swift
//  CodeBuddy
//
//  Created by Gavin Andrews on 6/14/18.
//  Copyright © 2018 Gavin Andrews. All rights reserved.
//

import UIKit
import FacebookLogin
import FacebookCore
import FirebaseAuth
import FirebaseDatabase
import FirebaseStorage

class SignUpViewController: UIViewController {
    @IBOutlet weak var meImage: UIImageView!
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var signupButton: UIButton!
    
    var pickedImage: UIImage!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
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
        let loginButton = LoginButton(readPermissions: [ .publicProfile, .email, .userFriends ])
//        loginButton.center = view.center
        loginButton.frame = CGRect(x: 16, y: 500, width: view.frame.width - 32, height: 44)
        loginButton.layer.cornerRadius = 10
        loginButton.clipsToBounds = true
        
        if AccessToken.current != nil {
        }
        
        view.addSubview(loginButton)
        
        meImage.layer.cornerRadius = 60.5
        meImage.clipsToBounds = true
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(SignUpViewController.handleSelectMeImageView))
        meImage.addGestureRecognizer(tapGesture)
        meImage.isUserInteractionEnabled = true
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
        Auth.auth().createUser(withEmail: emailTextField.text!, password: passwordTextField.text!, completion: { (user: User?, error: Error?) in
            if error != nil {
                print(error!.localizedDescription)
                return
            }
            let uid = user?.uid
            let storageRef = Storage.storage().reference(forURL: "gs://codebuddy-308e5.appspot.com").child("prof_Image").child((user?.uid)!)
            if let profImage = self.pickedImage, let dataImage = UIImageJPEGRepresentation(profImage, 0.1) {
                storageRef.putData(dataImage, metadata: nil, completion: { (metadata, error) in
                    if error != nil {
                        return
                    }
                    let profImageURL = metadata?.downloadURL()?.absoluteString
                    let ref = Database.database().reference()
                    let usersRef = ref.child("users")
                    let newUserRef = usersRef.child(uid!)
                    newUserRef.setValue(["username": self.usernameTextField.text!, "email": self.emailTextField.text!, "profileImageURL": profImageURL])
                    print("description: \(newUserRef.description())")
                })
            }
            // ...
        })
    }
}
extension SignUpViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        print("Finshed")
        if let image = info["UIImagePickerControllerOriginalImage"] as? UIImage {
            pickedImage = image
            meImage.image = image
        }
        dismiss(animated: true, completion: nil)
    }
}

