//
//  DemoObject.swift
//  ReactiveSwift-Demo
//
//  Created by Ravindra Soni on 05/01/17.
//  Copyright © 2017 Nickelfox. All rights reserved.
//

import Foundation
import JSONParsing

final public class DemoObject {
	
}

extension DemoObject: JSONParseable {
	public static func parse(_ json: JSON) throws -> DemoObject {
		return DemoObject()
	}
}
