//
//  SplashViewController.swift
//  CodeBuddy
//
//  Created by Gavin Andrews on 6/21/18.
//  Copyright © 2018 Gavin Andrews. All rights reserved.
//

import UIKit

class SplashViewController: UIViewController {

    @IBOutlet weak var particleView: SplashView!{
        didSet {
            particleView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(addDrop(recognizer:))))
        }
    }
    
    @objc func addDrop(recognizer: UITapGestureRecognizer) {
        if recognizer.state == .ended {
            particleView.addDrop()
        }
    }
}
