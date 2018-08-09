//
//  Loader.swift
//  ReactiveSwift-Demo
//
//  Created by Ravindra Soni on 16/12/16.
//  Copyright © 2016 Nickelfox. All rights reserved.
//

import UIKit
import ReactiveSwift
import MBProgressHUD

class Loader {
	
	static func showAdded(to view: UIView, animated: Bool){
		MBProgressHUD.showAdded(to: view, animated: animated)
	}

	static func hide(for view: UIView, animated: Bool){
		MBProgressHUD.hide(for: view, animated: animated)
	}
}

extension UIViewController {
	
	func showLoader(animated: Bool = false) {
		Loader.showAdded(to: self.view, animated: animated)
	}

	func hideLoader(animated: Bool = false) {
		Loader.hide(for: self.view, animated: animated)
	}
	
}

extension Reactive where Base: UIView {
    public var showLoader: BindingTarget<Bool> {
        return makeBindingTarget({ (view, showLoader) in
            if showLoader {
                Loader.showAdded(to: view, animated: true)
            } else {
                Loader.hide(for: view, animated: true)
            }
        })
    }
}
