//
//  SectionViewModel.swift
//  ReactiveSwift-Demo
//
//  Created by Vaibhav Parmar on 08/08/18.
//  Copyright © 2018 Nickelfox. All rights reserved.
//

import Foundation

public class SectionModel {
    var headerViewModel: Any?
    var cellModels: [Any] = []
    var footerViewModel: Any?
    
    init(headerViewModel: Any? = nil,
         cellModels: [Any] = [],
         footerViewModel: Any? = nil) {
     
        self.headerViewModel = headerViewModel
        self.cellModels = cellModels
        self.footerViewModel = footerViewModel
    }
}
