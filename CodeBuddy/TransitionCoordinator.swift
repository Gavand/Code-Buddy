//
//  TransitionCoordinator.swift
//  CodeBuddy
//
//  Created by Gavin Andrews on 1/22/19.
//  Copyright © 2019 Gavin Andrews. All rights reserved.
//

import UIKit

class TransitionCoordinator: NSObject, UINavigationControllerDelegate {

    func navigationController(_ navigationController: UINavigationController,
                              animationControllerFor operation: UINavigationController.Operation,
                              from fromVC: UIViewController,
                              to toVC: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return nil
    }
}
