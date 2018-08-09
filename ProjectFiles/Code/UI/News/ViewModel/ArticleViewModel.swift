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

class ArticleViewModel {
    
    var loading = MutableProperty<Bool>(false)
    var cellModels = MutableProperty<[ArticleCellModel]>([])
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
            print(error) //TODO
        })
    }
    
    private(set) public var articles: [Article] = [] {
        didSet {
            self.cellModels.value = self.articles.map { ArticleCellModel($0) }
        }
    }
    
    private let fetchArticleAction = Action { (source: Source) -> SignalProducer<[Article], NewsError> in
        return Article.fetchSources(from: source)
    }
}

extension ArticleViewModel {
    func fetchArticles(from source: Source) {
        self.disposable += self.fetchArticleAction.apply(source).start()
    }
    
    var rowCount: Int {
        return self.cellModels.value.count
    }
    
    func cellModel(at indexPath: IndexPath) -> ArticleCellModel {
        return self.cellModels.value[indexPath.row]
    }
}
