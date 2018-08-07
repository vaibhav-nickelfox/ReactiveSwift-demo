//
//  DemoRouter.swift
//  TemplateProject
//
//  Created by Ravindra Soni on 05/01/17.
//  Copyright © 2017 Nickelfox. All rights reserved.
//

import Foundation
import FoxAPIKit

public enum DemoRouter: BaseRouter {
	case demo
	
	public var method: HTTPMethod {
		switch self {
		case .demo:
			return .get
		}
	}
	
	public var path: String {
		switch self {
		case .demo:
			return "/get"
		}
	}
	
	public var params: [String: Any] {
		switch self {
		case .demo:
			return [:]
		}
	}
		
	public var headers: [String: String] {
		return ["Content-Type": "application/json"]
	}
	
}
