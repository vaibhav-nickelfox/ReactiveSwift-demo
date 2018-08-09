//
//  CategoryViewModel.swift
//  ReactiveSwift-Demo
//
//  Created by Vaibhav Parmar on 08/08/18.
//  Copyright © 2018 Nickelfox. All rights reserved.
//

import Foundation
import Model
import ReactiveSwift

class CategoryViewModel {
    
    var loading = MutableProperty<Bool>(false)
    var cellModels = MutableProperty<[CategoryCellModel]>([])
    var disposable = CompositeDisposable([])
    
    init() {
        self.disposable += self.loading <~ self.fetchSourceAction.isExecuting
        self.disposable += self.fetchSourceAction.values.observeValues({ sources in
            self.sources = sources
        })
        self.disposable += self.fetchSourceAction.errors.observeValues({ error in
            print(error) //TODO
        })
    }
    
    private(set) public var sources: [Source] = [] {
        didSet {
            self.cellModels.value = Model.Category.categorise(sources: sources).map {
                CategoryCellModel($0)
            }
        }
    }
    
    private let fetchSourceAction = Action { () -> SignalProducer<[Source], NewsError> in
        return Source.fetchSources()
    }
}

extension CategoryViewModel {
    
    func fetchSources() {
        self.disposable += self.fetchSourceAction.apply().start()
    }
    
    var rowCount: Int {
        return self.cellModels.value.count
    }
    
    func cellModel(at indexPath: IndexPath) -> CategoryCellModel {
        return self.cellModels.value[indexPath.row]
    }
}
