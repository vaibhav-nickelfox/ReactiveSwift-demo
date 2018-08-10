//
//  CategoryCellModel.swift
//  ReactiveSwift-Demo
//
//  Created by Vaibhav Parmar on 08/08/18.
//  Copyright © 2018 Nickelfox. All rights reserved.
//

import Foundation
import Model

struct CategoryCellModel {
    private let category: Model.Category
    
    init(_ category: Model.Category) {
        self.category = category
    }
    
    var title: String { return category.key }
    var sources: [Source] { return category.sources}
}
