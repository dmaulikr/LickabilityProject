//
//  API.swift
//  Lickability
//
//  Created by Komran Ghahremani on 8/9/17.
//  Copyright © 2017 Komran Ghahremani. All rights reserved.
//

import Foundation
import Alamofire

enum Result<T> {
    case success(T)
    case failure
}

typealias JSON = [String: Any]

class API: NSObject, DataFetcher {
    static let shared = API()
    let queue = DispatchQueue(label: "com.komran.Lickability.networking", qos: .utility, attributes: [.concurrent])
}

protocol DataFetcher {
    typealias APICompletionHandler = (Result<[JSON]>) -> Void
    func fetchData(for url: String, completion: @escaping APICompletionHandler)
}

extension DataFetcher {
    func fetchData(for url: String, completion: @escaping APICompletionHandler) {
        Alamofire.request(url).response(responseSerializer: DataRequest.jsonResponseSerializer(),
                                        completionHandler: { response in
                                            if let json = response.result.value as? [JSON], response.error == nil {
                                                completion(.success(json))
                                            } else {
                                                completion(.failure)
                                            }
        })
    }
}

// SWIFT 4
// Add typealias JSON = [String: Element] to DataFetcher protocol

// let json = response.value as? String
// let _ = json?.data(using: .utf8)!
// let decoder = JSONDecoder()
// let result = try! decoder.decode([JSON].self, from: data)
// completion(.success(result))
// in View Model will get result: [Element] in completion and set that as its instance variable collection
