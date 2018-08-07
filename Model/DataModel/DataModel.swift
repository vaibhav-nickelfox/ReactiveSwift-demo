//
//  DataModel.swift
//  ReactiveSwift-Demo
//
//  Created by Ravindra Soni on 05/01/17.
//  Copyright © 2017 Nickelfox. All rights reserved.
//

import Foundation
import FoxAPIKit

public typealias APICompletion<T> = (APIResult<T>) -> Void

public class  DataModel {
	
	public static func test(completion: @escaping APICompletion<DemoObject>) {
		TestAPIClient.shared.request(DemoRouter.demo, completion: completion)
	}
	
}
