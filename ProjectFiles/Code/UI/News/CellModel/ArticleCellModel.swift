//
//  ArticleCellModel.swift
//  ReactiveSwift-Demo
//
//  Created by Vaibhav Parmar on 08/08/18.
//  Copyright © 2018 Nickelfox. All rights reserved.
//

import Foundation
import Model

protocol ArticleCellProtocol {
    var title: String { get }
    var description: String { get }
    var source: String { get }
    var urlLink: String { get }
    var imageLink: String { get }
    var date: String { get }
}

struct ArticleCellModel: ArticleCellProtocol {
    
    private let article: Article
    
    init(_ article: Article) {
        self.article = article
    }
    
    var title: String { return article.title }
    var description: String { return article.description }
    var source: String { return article.source }
    var urlLink: String { return article.urlLink }
    var imageLink: String { return article.imageLink }
    var date: String { return article.date }
}
