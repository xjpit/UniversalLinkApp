//
//  UniversalLinkAppApp.swift
//  UniversalLinkApp
//
//  Created by Goh Chong Yong on 4/1/24.
//

import SwiftUI

@main
struct UniversalLinkApp: App {
    
    @State private var viewModel = LoginViewModel()
    
    var body: some Scene {
        WindowGroup {
            LoginView()
                .onOpenURL { url in
                    print(url)
                    Task {
                        try await viewModel.authenticateMagicLink(url: url)
                    }
                }
        }
    }
}
