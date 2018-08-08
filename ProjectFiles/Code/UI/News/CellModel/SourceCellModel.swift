//
//  SourceCellModel.swift
//  ReactiveSwift-Demo
//
//  Created by Vaibhav Parmar on 08/08/18.
//  Copyright © 2018 Nickelfox. All rights reserved.
//

import Foundation
import Model

protocol SourceCellProtocol {
    var title: String { get }
}

struct SourceCellModel: SourceCellProtocol {
    private let source: Source
    
    init(_ source: Source) {
        self.source = source
    }
    
    var title: String { return source.name }
}
