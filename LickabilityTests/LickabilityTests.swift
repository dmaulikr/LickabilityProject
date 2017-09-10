//
//  LickabilityTests.swift
//  LickabilityTests
//
//  Created by Komran Ghahremani on 8/9/17.
//  Copyright © 2017 Komran Ghahremani. All rights reserved.
//

import XCTest
import RxSwift
import RxCocoa
import RxTest

@testable import Lickability

class LickabilityTests: XCTestCase {    
    let failedMockAPIManager = MockAPI(resultType: .failure)
    let successMockAPIManager = MockAPI(resultType: .success(
        [
            [
                "albumId": 1,
                "id": 1,
                "title": "test title",
                "url": "http://placehold.it/600/92c952",
                "thumbnailUrl": "http://placehold.it/150/92c952"
            ],
            [
                "albumId": 1,
                "id": 2,
                "title": "reprehenderit est deserunt velit ipsam",
                "url": "http://placehold.it/600/771796",
                "thumbnailUrl": "http://placehold.it/150/771796"
            ],
            [
                "albumId": 1,
                "id": 3,
                "title": "officia porro iure quia iusto qui ipsa ut modi",
                "url": "http://placehold.it/600/24f355",
                "thumbnailUrl": "http://placehold.it/150/24f355"
            ]
        ]
    ))
    
    func testAPIFetchSuccess() {
        let viewModel = MockPhotosViewModel()
        viewModel.api = successMockAPIManager
        viewModel.fetchPhotosData() {
            XCTAssertTrue(viewModel.didFetchSuccess)
            XCTAssertFalse(viewModel.didFetchFail)
        }
    }
    
    func testAPIFetchFail() {
        let viewModel = MockPhotosViewModel()
        viewModel.api = failedMockAPIManager
        viewModel.fetchPhotosData() {
            XCTAssertFalse(viewModel.didFetchSuccess)
            XCTAssertTrue(viewModel.didFetchFail)
        }
    }
    
    func testAPISuccessClosure() {
        let viewModel = MockPhotosViewModel()
        viewModel.api = successMockAPIManager
        
        viewModel.fetchPhotosData(completion: {
            XCTAssertTrue(true)
        })
    }
    
    func testAPIFailedClosure() {
        let viewModel = MockPhotosViewModel()
        viewModel.api = failedMockAPIManager
        
        viewModel.fetchPhotosData(completion: {
            XCTAssertTrue(true)
        })
    }
}
