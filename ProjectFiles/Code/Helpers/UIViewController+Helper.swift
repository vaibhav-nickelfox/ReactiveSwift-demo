//
//  UIViewController+Helper.swift
//  ReactiveSwift-Demo
//
//  Created by Vaibhav Parmar on 09/08/18.
//  Copyright © 2018 Nickelfox. All rights reserved.
//

import Foundation
import UIKit
import Model
import FoxAPIKit

extension UIViewController {
    func handleError(_ error: AnyError) {
        self.showErrorAlert(message: error.message)
    }
}
