//
//  MeViewController.swift
//  CodeBuddy
//
//  Created by Gavin Andrews on 6/20/18.
//  Copyright © 2018 Gavin Andrews. All rights reserved.
//

import UIKit
import FirebaseAuth

class MeViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    

    
    @IBAction func logout_TouchUpInside(_ sender: Any) {
    do {
        try Auth.auth().signOut()
    }catch let logoutError {
            print(logoutError)
        }
        let storyboard = UIStoryboard(name: "Start", bundle: nil)
        let loginVC = storyboard.instantiateViewController(withIdentifier: "LoginViewController")
        self.present(loginVC, animated: true, completion: nil)
    }
}
