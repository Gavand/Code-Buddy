//
//  LoginViewController.swift
//  CodeBuddy
//
//  Created by Gavin Andrews on 6/13/18.
//  Copyright © 2018 Gavin Andrews. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {

    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var loginButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
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
        
        loginButton.layer.cornerRadius = 10
        loginButton.clipsToBounds = true
    }
}
