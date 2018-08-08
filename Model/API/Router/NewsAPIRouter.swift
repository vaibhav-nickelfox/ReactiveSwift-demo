//
//  NewsAPIRouter.swift
//  Model
//
//  Created by Vaibhav Parmar on 08/08/18.
//  Copyright © 2018 Nickelfox. All rights reserved.
//

import Foundation
import FoxAPIKit

public enum NewsAPIRouter: BaseRouter {
    case articles(source: String)
    case sources
}

extension NewsAPIRouter {
    public var method: HTTPMethod {
        let method: HTTPMethod
        switch self {
        case .sources, .articles:
            method = .get
        }
        return method
    }
    
    public var path: String {
        switch self {
        case .sources: return "/sources"
        case .articles: return "/articles"
        }
    }
    
    public var params: [String: Any] {
        var parameters: [String: Any]
        switch self {
        case .sources:
            parameters = ["language": "en"]
        case .articles(let source):
            parameters = ["apiKey": APIConfig.apikey,
                          "source": source,
                          "sortBy": "top"]
        }
        return parameters
    }
            
    public var keypathToMap: String? {
        let keyPath: String
        switch self {
        case .sources: keyPath = "sources"
        case .articles: keyPath = "articles"
        }
        return keyPath
    }

}
