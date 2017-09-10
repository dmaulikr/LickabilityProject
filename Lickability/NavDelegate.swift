//
//  NavDelegate.swift
//  Lickability
//
//  Created by Komran Ghahremani on 8/10/17.
//  Copyright © 2017 Komran Ghahremani. All rights reserved.
//

import UIKit

// Inspiration: http://blog.rinatkhanov.me/ios/transitions.html

class NavDelegate: NSObject, UINavigationControllerDelegate {
    private let animator = DetailTransition()
    
    func navigationController(_ navigationController: UINavigationController, animationControllerFor operation: UINavigationControllerOperation, from fromVC: UIViewController, to toVC: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return animator
    }
}
