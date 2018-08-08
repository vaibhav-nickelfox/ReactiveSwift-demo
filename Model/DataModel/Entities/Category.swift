//
//  Category.swift
//  Model
//
//  Created by Vaibhav Parmar on 08/08/18.
//  Copyright © 2018 Nickelfox. All rights reserved.
//

import Foundation

public class Category {
    public var key: String
    public var sources: [Source]
    
    public init(key: String, sources: [Source]) {
        self.key = key
        self.sources = sources
    }
    
    public static func categorise(sources: [Source]) -> [Category] {
        var categories: [Category] = []
        for source in sources {
            if let index = self.indexOfCategory(key: source.category, in: categories) {
                let foundCategory = categories[index]
                foundCategory.sources.append(source)
            } else {
                categories.append(Category(key: source.category, sources: sources))
            }
        }
        return categories
    }
    
    private static func indexOfCategory(key: String, in categories: [Category]) -> Int? {
        var index = 0
        for category in categories {
            if key == category.key { return index }
            index += 1
        }
        return nil
    }
}
