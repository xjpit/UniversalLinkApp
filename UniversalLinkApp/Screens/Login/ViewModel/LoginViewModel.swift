//
//  LoginViewModel.swift
//  UniversalLinkApp
//
//  Created by Goh Chong Yong on 4/1/24.
//

import Foundation
import Observation

@Observable class LoginViewModel {
    
    var email: String = ""
    
    let BASE_URL = "https://universallink.vercel.app"
    
    var loginURL: String {
        return "\(BASE_URL)/api/auth/login"
    }
    
    var magicLinkVerificationURL: String {
        return "\(BASE_URL)/api/auth/login/verify/app?token="
    }
    
}

extension LoginViewModel {
    
    func getMagicLink() async throws -> Void {
        do {
            guard let url = URL(string: loginURL) else { throw NetworkError.invalidURL }
            var request = URLRequest(url: url)
            request.httpMethod = "POST"
            request.addValue("application/json", forHTTPHeaderField: "Content-Type")
            let credentials = LoginCredentials(email: email.self)
            request.httpBody = try? JSONEncoder().encode(credentials)
            let (_, response) = try await URLSession.shared.data(for: request)
            guard (response as? HTTPURLResponse)?.statusCode == 200 else { throw AuthenticationErrors.credentialCheckFailed }
            return
        } catch {
            throw NetworkError.unknown(error)
        }
    }
    
    func authenticateMagicLink(url: URL) async throws -> String {
        do {
            let components = URLComponents(
                url: url,
                resolvingAgainstBaseURL: false
            )!
            let magicToken = components.queryItems?.first(where: { $0.name == "token" })?.value
            guard let url = URL(string: "\(magicLinkVerificationURL)\(magicToken!)") else { throw NetworkError.invalidURL }
            let (data, response) = try await URLSession.shared.data(from: url)
            guard (response as? HTTPURLResponse)?.statusCode == 200 else {
                print("Error here")
                throw NetworkError.serverError
            }
            guard let jwtToken = try? JSONDecoder().decode(String.self, from: data) else {
                print("Error there")
                throw NetworkError.invalidData
            }
            print("JWT: \(jwtToken)")
            return jwtToken
        } catch {
            throw NetworkError.unknown(error)
        }
    }
}
