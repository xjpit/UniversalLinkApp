//
//  AuthenticationErrors.swift
//  UniversalLinkApp
//
//  Created by Goh Chong Yong on 4/1/24.
//

import Foundation

enum AuthenticationErrors: Error, LocalizedError {
    case credentialCheckFailed
    
    var errorDescription: String? {
        switch self {
        case .credentialCheckFailed:
            return "Login Failed. Check credentials or contact support."
        }
    }
}
