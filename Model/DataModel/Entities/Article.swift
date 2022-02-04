//
//  Article.swift
//  Model
//
//  Created by Vaibhav Parmar on 08/08/18.
//  Copyright © 2018 Nickelfox. All rights reserved.
//

import Foundation
import JSONParsing

final public class Article {
    public var title: String
    public var description: String
    public var date: String
    public var urlLink: String
    public var imageLink: String
    public var source: String
    
    public init(title: String, description: String,
                date: String, urlLink: String,
                imageLink: String, source: String = "") {
        self.title = title
        self.description = description
        self.date = date
        self.urlLink = urlLink
        self.imageLink = imageLink
        self.source = source
    }
}

extension Article: JSONParseable {
    
    public static func parse(_ json: JSON) throws -> Article {
        return Article(title: json["title"]^!,
                           description: json["description"]^!,
                           date: json["publishedAt"]^!,
                           urlLink: json["url"]^!,
                           imageLink: json["urlToImage"]^!,
                           source: "")
    }
}
