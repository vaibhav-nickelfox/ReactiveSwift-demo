//
//  CollectionViewCell.swift
//  ReactiveSwift-Demo
//
//  Created by Vaibhav Parmar on 08/08/18.
//  Copyright © 2018 Nickelfox. All rights reserved.
//

import UIKit

class CollectionViewCell: UICollectionViewCell {
    var item: Any? {
        didSet {
            self.configure(self.item)
        }
    }
    
    weak var delegate: NSObjectProtocol? = nil
    
    func configure(_ item: Any?) { }
}

class CollectionReusableView: UICollectionReusableView {
    var item: Any? {
        didSet {
            self.configure(self.item)
        }
    }
    
    weak var delegate: NSObjectProtocol? = nil
    
    func configure(_ item: Any?) { }
}
