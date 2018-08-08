//
//  Source.swift
//  Model
//
//  Created by Vaibhav Parmar on 08/08/18.
//  Copyright © 2018 Nickelfox. All rights reserved.
//

import Foundation
import JSONParsing

final public class Source {
    public var id: String
    public var name: String
    public var category: String
    
    public init(id: String, name: String, category: String) {
        self.id = id
        self.name = name
        self.category = category
    }
}

extension Source: JSONParseable {
    
    public static func parse(_ json: JSON) throws -> Source {
        return try Source(id: json["id"]^,
                          name: json["name"]^!,
                          category: json["category"]^!)
    }
    
}
