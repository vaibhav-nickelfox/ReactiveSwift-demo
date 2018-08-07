//
//  ErrorResponse.swift
//  TemplateProject
//
//  Created by Ravindra Soni on 05/01/17.
//  Copyright © 2017 Nickelfox. All rights reserved.
//

import Foundation
import FoxAPIKit
import JSONParsing

private let errorKey = "error"

public struct ErrorResponse: ErrorResponseProtocol {
    public var domain: String {
        return ""
    }
    
    public static func parse(_ json: JSON, code: Int) throws -> ErrorResponse {
        if 200...299 ~= code {
            throw NSError(domain: "", code: code, userInfo: nil)
        }
        return try ErrorResponse(code: code, messages: [json["message"]^])
    }
    
    public var code: Int
    public let messages: [String]
    public var message: String {
        return compiledErrorMessage
    }
    
    public var compiledErrorMessage: String {
        return messages.joined(separator: ",")
    }
}
