//
//  ImageView.swift
//  ReactiveSwift-Demo
//
//  Created by Ravindra Soni on 18/12/16.
//  Copyright © 2016 Nickelfox. All rights reserved.
//

import Foundation
import UIKit
import Kingfisher

public class ImageView: UIImageView {
	
	let activity = UIActivityIndicatorView(activityIndicatorStyle: UIActivityIndicatorViewStyle.whiteLarge)
	
	public override func awakeFromNib() {
		super.awakeFromNib()
		self.addSubview(self.activity)
	}
	
	public override func layoutSubviews() {
		super.layoutSubviews()
		self.activity.frame = self.bounds;
	}
	
	public func setImageFromUrl(urlString: String, placeHolder: UIImage? = nil) {
		guard let url = URL(string: urlString) else {
			return
		}
        
        self.image = placeHolder
        self.kf.setImage(with: url,
                         placeholder: nil,
                         options: [.transition(ImageTransition.fade(0.5))],
                         progressBlock: { (_,_) in },
                         completionHandler: { image, error, cacheType, imageURL in
        })

	}
	
	private func startLoader() {
		activity.isHidden = false
		activity.startAnimating()
	}
	
	private func stopLoader() {
		activity.isHidden = true
		activity.stopAnimating()
	}
}

extension ImageView {
    func loadGif(_ named: String) {
        guard let url = Bundle.main.url(forResource: named, withExtension: ".gif") else { return }
        self.setImageFromUrl(urlString: url.absoluteString)
    }    
}

