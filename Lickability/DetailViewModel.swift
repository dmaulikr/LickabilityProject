//
//  DetailViewModel.swift
//  Lickability
//
//  Created by Komran Ghahremani on 8/14/17.
//  Copyright © 2017 Komran Ghahremani. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class DetailViewModel: NSObject {
    var photo: Variable<Photo> = Variable<Photo>(Photo())
    var color: UIColor = UIColor()
}
