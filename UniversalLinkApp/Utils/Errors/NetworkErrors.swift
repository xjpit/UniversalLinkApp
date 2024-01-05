//
//  NetworkErrors.swift
//  UniversalLinkApp
//
//  Created by Goh Chong Yong on 4/1/24.
//

import Foundation

enum NetworkError: Error, LocalizedError {
    case invalidURL
    case serverError
    case invalidData
    case unknown(Error)
    
    var errorDescription: String? {
        switch self {
        case .invalidURL:
            return "Invalid URL found"
            
        case .serverError:
            return "There is an error with the server. Please try again later."
            
        case .invalidData:
            return "Invalid Data. Try again"
            
        case .unknown(let error):
            return error.localizedDescription
        }
    }
}
