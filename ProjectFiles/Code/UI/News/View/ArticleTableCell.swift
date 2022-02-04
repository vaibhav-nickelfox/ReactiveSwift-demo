//
//  ArticleTableCell.swift
//  ReactiveSwift-Demo
//
//  Created by Vaibhav Parmar on 08/08/18.
//  Copyright © 2018 Nickelfox. All rights reserved.
//

import UIKit

class ArticleTableCell: TableViewCell {

    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var sourceNameLabel: UILabel!
    @IBOutlet var newsImageView: ImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    override func configure(_ item: Any?) {
        guard let cellModel = item as? ArticleCellModel else { return }
        self.titleLabel.text = cellModel.title
        self.sourceNameLabel.text = cellModel.source
        self.newsImageView.setImageFromUrl(urlString: cellModel.imageLink)
    }
}
