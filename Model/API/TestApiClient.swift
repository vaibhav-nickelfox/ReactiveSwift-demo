//
//  TestApiClient.swift
//  ReactiveSwift-Demo
//
//  Created by Ravindra Soni on 06/01/17.
//  Copyright © 2017 Nickelfox. All rights reserved.
//

import Foundation
import FoxAPIKit

class TestAPIClient: APIClient<AuthHeaders, ErrorResponse> {

	static let shared = TestAPIClient()
    
    override init() {
        super.init()
        #if DEBUG
        enableLogs = true
        #endif
    }
	
}
