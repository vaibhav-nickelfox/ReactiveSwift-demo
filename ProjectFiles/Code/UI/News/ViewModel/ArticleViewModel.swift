//
//  ArticleViewModel.swift
//  ReactiveSwift-Demo
//
//  Created by Vaibhav Parmar on 08/08/18.
//  Copyright © 2018 Nickelfox. All rights reserved.
//

import Foundation
import Model
import ReactiveSwift

enum SortBy {
    case top
    case latest
    case popular
    
    var value: String {
        switch self {
        case .top:
            return "top"
        case .latest:
            return "latest"
        case .popular:
            return "popular"
        }
    }
}

class ArticleViewModel {
    
    var loading = MutableProperty<Bool>(false)
    var cellModels = MutableProperty<[ArticleCellModel]>([])
    var error = MutableProperty<NewsError?>(nil)
    var disposable = CompositeDisposable([])
    
    deinit {
        self.disposable.dispose()
    }
    
    init() {
        self.disposable += self.loading <~ self.fetchArticleAction.isExecuting
        self.disposable += self.fetchArticleAction.values.observeValues({ articles in
            self.articles = articles
        })
        self.disposable += self.fetchArticleAction.errors.observeValues({ error in
            self.error.value = error
        })
    }
    
    private(set) public var articles: [Article] = [] {
        didSet {
            self.cellModels.value = self.articles.map { ArticleCellModel($0) }
        }
    }
    
    private let fetchArticleAction = Action { (source: Source, sortBy: SortBy) -> SignalProducer<[Article], NewsError> in
        return Article.fetchArticles(from: source, sortBy: sortBy.value)
    }
}

extension ArticleViewModel {
    func fetchArticles(from source: Source, sortBy: SortBy) {
        self.disposable += self.fetchArticleAction.apply((source, sortBy)).start()
    }
    
    var rowCount: Int {
        return self.cellModels.value.count
    }
    
    func cellModel(at indexPath: IndexPath) -> ArticleCellModel {
        return self.cellModels.value[indexPath.row]
    }
}
