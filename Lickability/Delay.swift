//
//  delay.swift
//  Lickability
//
//  Created by Komran Ghahremani on 8/11/17.
//  Copyright © 2017 Komran Ghahremani. All rights reserved.
//

import Foundation

func delay(for duration: Double, with task: @escaping () -> Void) {
    let at = DispatchTime.now() + duration
    DispatchQueue.main.asyncAfter(deadline: at, execute: task)
}
