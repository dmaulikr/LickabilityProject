//
//  PhotosViewModel.swift
//  Lickability
//
//  Created by Komran Ghahremani on 8/9/17.
//  Copyright © 2017 Komran Ghahremani. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

class PhotosViewModel: NSObject {
    fileprivate var api = API.shared
    var photos: Variable<[Photo]> = Variable<[Photo]>([])
    var error: Variable<String> = Variable<String>("")
    typealias FetchCompletionHandler = () -> ()
    
    func fetchPhotosData(completion: FetchCompletionHandler? = nil) {
        api.fetchData(for: "http://jsonplaceholder.typicode.com/photos") { result in
            switch result {
            case .success(let json):
                self.photos.value = json.flatMap(Photo.init)
            case .failure:
                self.error.value = "Data could not be retrieved"
            }
            
            completion?()
        }
    }
}
