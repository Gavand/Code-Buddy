//
//  SplashBehavior.swift
//  CodeBuddy
//
//  Created by Gavin Andrews on 1/31/19.
//  Copyright © 2019 Gavin Andrews. All rights reserved.
//

import UIKit

class SplashBehavior: UIDynamicBehavior {
    
    let gravity = UIGravityBehavior()

    lazy var collider: UICollisionBehavior = {
        let createdCollider = UICollisionBehavior()
        createdCollider.translatesReferenceBoundsIntoBoundary = true
        return createdCollider
    }()
    
    lazy var splashBehavior: UIDynamicItemBehavior = {
        let createdSplashBehavior = UIDynamicItemBehavior()
        createdSplashBehavior.elasticity = 0.75
        return createdSplashBehavior
    }()
    
//    func barrier(path: UIBezierPath, named name: String) {
//        collider.removeBoundary(withIdentifier: name as NSCopying)
//        collider.addBoundary(withIdentifier: name as NSCopying, for: path)
//    }

    override init() {
        super.init()
        addChildBehavior(gravity)
        addChildBehavior(collider)
        addChildBehavior(splashBehavior)
    }

    func addSplash(drop: UIView) {
        dynamicAnimator?.referenceView?.addSubview(drop)
        gravity.addItem(drop)
        collider.addItem(drop)
        splashBehavior.addItem(drop)

    }

    func removeSplash(drop: UIView) {
        gravity.removeItem(drop)
        collider.removeItem(drop)
        splashBehavior.removeItem(drop)
        drop.removeFromSuperview()
    }
}
