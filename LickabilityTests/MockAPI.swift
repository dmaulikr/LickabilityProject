//
//  MockAPI.swift
//  Lickability
//
//  Created by Komran Ghahremani on 8/14/17.
//  Copyright © 2017 Komran Ghahremani. All rights reserved.
//

import UIKit

class MockAPI: API {
    var resultType: Result<[JSON]>
    
    init(resultType: Result<[JSON]>) {
        self.resultType = resultType
    }
    
    override func loadJSONFromRequest(url: String, completion: @escaping APICompletionHandler) {
        return completion(self.resultType)
    }
}
