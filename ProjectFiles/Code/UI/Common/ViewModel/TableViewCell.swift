//
//  TableViewCell.swift
//  ReactiveSwift-Demo
//
//  Created by Vaibhav Parmar on 08/08/18.
//  Copyright © 2018 Nickelfox. All rights reserved.
//

import UIKit

class TableViewCell: UITableViewCell {
    var item: Any? {
        didSet {
            self.configure(self.item)
        }
    }
    
    weak var delegate: NSObjectProtocol? = nil
    
    func configure(_ item: Any?) { }
}

class TableHeaderFooterView: UITableViewHeaderFooterView {
    var item: Any? {
        didSet {
            self.configure(item)
        }
    }
    
    weak var delegate: NSObjectProtocol? = nil
    
    func configure(_ item: Any?) { }
}
