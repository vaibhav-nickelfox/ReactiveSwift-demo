//
//  Article+API.swift
//  Model
//
//  Created by Vaibhav Parmar on 08/08/18.
//  Copyright © 2018 Nickelfox. All rights reserved.
//

import Foundation
import FoxAPIKit
import ReactiveSwift

extension Article {
    
    public static func fetchArticles(from source: Source, sortBy: String) -> SignalProducer<[Article], NewsError> {
        return SignalProducer.init({ (observer, lifetime) in
            let router = NewsAPIRouter.articles(source: source.id, sortBy: sortBy)
            ReactiveSwiftAPIClient.shared.request(router) { (response: APIResult<ListResponse<Article>>) in
                
                switch response {
                case .success(let result):
                    let articles: [Article] = result.list.map {
                        $0.source = source.name
                        return $0
                    }
                    observer.send(value: articles)
                    observer.sendCompleted()
                case .failure(let error):
                    observer.send(error: NewsError.custom(message: error.message))
                }
                
            }
        })
    }
}
