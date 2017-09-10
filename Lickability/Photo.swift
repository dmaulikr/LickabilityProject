//
//  Photo.swift
//  Lickability
//
//  Created by Komran Ghahremani on 8/9/17.
//  Copyright © 2017 Komran Ghahremani. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

struct Photo {
    var albumId: Int = 0
    var id: Int = 0
    var title: String = ""
    var url: String = ""
    var thumbnailUrl: String = ""
}

extension Photo {
    init(_ dictionary: JSON) {
        
        if let albumId = dictionary["albumId"] as? Int {
            self.albumId = albumId
        }
        
        if let id = dictionary["id"] as? Int {
            self.id = id
        }
        
        if let title = dictionary["title"] as? String {
            self.title = title
        }
        
        if let url = dictionary["url"] as? String {
            self.url = url
        }
        
        if let thumbnailUrl = dictionary["thumbnailUrl"] as? String {
            self.thumbnailUrl = thumbnailUrl
        }
    }
}
