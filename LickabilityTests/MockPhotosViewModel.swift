//
//  MockPhotosViewModel.swift
//  Lickability
//
//  Created by Komran Ghahremani on 8/15/17.
//  Copyright © 2017 Komran Ghahremani. All rights reserved.
//

import RxSwift
import RxCocoa

class MockPhotosViewModel: NSObject {
    var api: MockAPI?
    var didFetchSuccess: Bool = false
    var didFetchFail: Bool = false
    var didCompleteWithCallback: Bool = false
    typealias FetchCompletionHandler = () -> ()
    
    func fetchPhotosData(completion: FetchCompletionHandler? = nil) {
        api?.loadJSONFromRequest(url: "") { result in
            switch result {
            case .success(_):
                self.didFetchSuccess = true
            case .failure:
                self.didFetchFail = true
            }
            
            completion?()
        }
    }
}
