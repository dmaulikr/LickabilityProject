//
//  PresentAlert.swift
//  Lickability
//
//  Created by Komran Ghahremani on 8/16/17.
//  Copyright © 2017 Komran Ghahremani. All rights reserved.
//

import UIKit

func alert(with message: String, and actions: UIAlertAction...) -> UIAlertController {
    let alert = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
    for action in actions {
        alert.addAction(action)
    }
    
    return alert
}
