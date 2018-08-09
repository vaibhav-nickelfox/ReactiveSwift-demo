//
//  ReactiveSwiftAPIClient.swift
//  ReactiveSwift-Demo
//
//  Created by Ravindra Soni on 06/01/17.
//  Copyright © 2017 Nickelfox. All rights reserved.
//

import Foundation
import FoxAPIKit

class ReactiveSwiftAPIClient: APIClient<AuthHeaders, ErrorResponse> {

	static let shared = ReactiveSwiftAPIClient()
    
    override init() {
        super.init()
        #if DEBUG
        super.enableLogs = false
        #endif
    }
	
}
