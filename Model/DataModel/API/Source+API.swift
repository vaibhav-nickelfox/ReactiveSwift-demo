//
//  Source+API.swift
//  Model
//
//  Created by Vaibhav Parmar on 08/08/18.
//  Copyright © 2018 Nickelfox. All rights reserved.
//

import Foundation
import ReactiveSwift
import FoxAPIKit

extension Source {
    
    public static func fetchArticles() -> SignalProducer<[Source], NewsError> {
        return SignalProducer.init({ (observer, lifetime) in
            ReactiveSwiftAPIClient.shared.request(NewsAPIRouter.sources) { (response: APIResult<ListResponse<Source>>) in
                switch response {
                case .success(let result):
                    observer.send(value: result.list)
                    observer.sendCompleted()
                case .failure(let error):
                    observer.send(error: NewsError.custom(message: error.message))
                }
            }
        })
    }
}
