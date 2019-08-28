//
//  LoginViewController.swift
//  CodeBuddy
//
//  Created by Gavin Andrews on 6/13/18.
//  Copyright © 2018 Gavin Andrews. All rights reserved.
//

import UIKit
import FirebaseAuth
import JGProgressHUD

class LoginViewController: UIViewController { //, UITextFieldDelegate
    
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var loginButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.hideKeyboardWhenTappedAround()
        
        
        
        emailTextField.backgroundColor = UIColor.clear
        emailTextField.attributedPlaceholder = NSAttributedString(string: emailTextField.placeholder!, attributes: [NSAttributedString.Key.foregroundColor: UIColor(red: (253/255), green: (178/255), blue: (43/255), alpha: 1)])
        let bottomLayerEmail = CALayer()
        bottomLayerEmail.frame = CGRect(x: 0, y: 29, width: 1000, height: 0.6)
        bottomLayerEmail.backgroundColor = UIColor(red: (253/255), green: (178/255), blue: (43/255), alpha: 1).cgColor
        emailTextField.layer.addSublayer(bottomLayerEmail)
        
        passwordTextField.backgroundColor = UIColor.clear
        passwordTextField.attributedPlaceholder = NSAttributedString(string: passwordTextField.placeholder!, attributes: [NSAttributedString.Key.foregroundColor: UIColor(red: (253/255), green: (178/255), blue: (43/255), alpha: 1)])
        let bottomLayerPassword = CALayer()
        bottomLayerPassword.frame = CGRect(x: 0, y: 29, width: 1000, height: 0.6)
        bottomLayerPassword.backgroundColor = UIColor(red: (253/255), green: (178/255), blue: (43/255), alpha: 1).cgColor
        passwordTextField.layer.addSublayer(bottomLayerPassword)
        
        loginButton.layer.cornerRadius = 10
        loginButton.clipsToBounds = true
        loginButton.isEnabled = false
        
        handleTextField()
    }
    
    override func touchesBegan(_ touhes: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        if Auth.auth().currentUser != nil {
            self.performSegue(withIdentifier: "loginToTabbar", sender: nil)
        }
    }
    //    func dismissKeyboard() {
    //        //Causes the view (or one of its embedded text fields) to resign the first responder status.
    //        view.endEditing(true)
    //    }
    //
    //    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
    //        emailTextField.resignFirstResponder()
    //        passwordTextField.resignFirstResponder()
    //        return true
    //    }
    func handleTextField() {
        emailTextField.addTarget(self, action: #selector(self.textFieldDidChange), for: UIControl.Event.editingChanged)
        passwordTextField.addTarget(self, action: #selector(self.textFieldDidChange), for: UIControl.Event.editingChanged)
    }
    @objc func textFieldDidChange() {
        guard let email = emailTextField.text, !email.isEmpty,
            let password = passwordTextField.text, !password.isEmpty else {
                loginButton.setTitleColor(UIColor.lightText, for: UIControl.State.normal)
                
                return
        }
        loginButton.setTitleColor(UIColor.white, for: UIControl.State.normal)
        loginButton.isEnabled = true
    }
    @IBAction func loginButton_TouchUpInside(_ sender: Any) {
        view.endEditing(true)
        let hud = JGProgressHUD(style: .dark)
        hud.textLabel.text = "Loading"
        hud.show(in: self.view)
        hud.dismiss(afterDelay: 3.0)
//        ProgressHUD.dismiss()
        AuthService.login(email: emailTextField.text!, password: passwordTextField.text!, onSuccess: {
//            ProgressHUD.dismiss()
//            let hud = JGProgressHUD(style: .dark)
            hud.textLabel.text = "Success"
            hud.indicatorView = JGProgressHUDSuccessIndicatorView()
            hud.show(in: self.view)
            hud.dismiss(afterDelay: 3.0)
            self.performSegue(withIdentifier: "loginToTabbar", sender: nil)
            
        }, onError: { errorString in
//            ProgressHUD.showError(error!)
//            let hud = JGProgressHUD(style: .dark)
//            print(error!)
            hud.textLabel.text = errorString
            hud.indicatorView = JGProgressHUDErrorIndicatorView()
            hud.show(in: self.view)
            hud.dismiss(afterDelay: 3.0)
            
        })
    }
}

extension UIViewController {
    func hideKeyboardWhenTappedAround() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true) 
    }
}
