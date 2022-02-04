//
//  SourceViewModel.swift
//  ReactiveSwift-Demo
//
//  Created by Vaibhav Parmar on 13/08/18.
//  Copyright © 2018 Nickelfox. All rights reserved.
//

import Foundation
import Model
import ReactiveSwift

class SourceViewModel {
    
    var loading = MutableProperty<Bool>(false)
    var cellModels = MutableProperty<[SourceCellModel]>([])
    var error = MutableProperty<NewsError?>(nil)
    var disposable = CompositeDisposable([])
    
    init() {
        self.disposable += self.loading <~ self.fetchSourceAction.isExecuting
        self.disposable += self.fetchSourceAction.values.observeValues({ sources in
            self.sources = sources
        })
        self.disposable += self.fetchSourceAction.errors.observeValues({ error in
            self.error.value = error
        })
    }
    
    private(set) public var sources: [Source] = [] {
        didSet {
            self.cellModels.value = self.sources.map { SourceCellModel($0) }
        }
    }
    
    private let fetchSourceAction = Action { (sources: [Source]) -> SignalProducer<[Source], NewsError> in
        
        return SignalProducer.init({ (observer, lifetime) in
            if sources.isEmpty {
                observer.send(error: NewsError.custom(message: "No sources found"))
                return
            }
            observer.send(value: sources)
            observer.sendCompleted()
        })
    }
}

extension SourceViewModel {
    func setSources(_ sources: [Source]) {
        self.disposable += self.fetchSourceAction.apply(sources).start()
    }
    
    var rowCount: Int {
        return self.cellModels.value.count
    }
    
    func cellModel(at indexPath: IndexPath) -> SourceCellModel {
        return self.cellModels.value[indexPath.row]
    }
}

