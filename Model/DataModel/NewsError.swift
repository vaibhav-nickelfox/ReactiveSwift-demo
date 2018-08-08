//
//  NewsError.swift
//  Model
//
//  Created by Vaibhav Parmar on 08/08/18.
//  Copyright © 2018 Nickelfox. All rights reserved.
//

import Foundation
import AnyErrorKit

public enum NewsError: AnyError {
    case unknown
    case custom(message: String)
    
    public var code: Int {
        return 0
    }
    
    public var domain: String {
        return "Error"
    }
    
    public var message: String {
        switch self {
        case .unknown: return "Oops! An unknown error has occured."
        case .custom(let message): return message
        }
    }
}
