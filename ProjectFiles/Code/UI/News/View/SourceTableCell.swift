//
//  SourceTableCell.swift
//  ReactiveSwift-Demo
//
//  Created by Vaibhav Parmar on 08/08/18.
//  Copyright © 2018 Nickelfox. All rights reserved.
//

import UIKit

class SourceTableCell: TableViewCell {

    @IBOutlet var sourceLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    override func configure(_ item: Any?) {
        guard let cellModel = item as? SourceCellModel else { return }
        self.sourceLabel.text = cellModel.title
    }
}
