//
//  LoginView.swift
//  UniversalLinkApp
//
//  Created by Goh Chong Yong on 4/1/24.
//

import SwiftUI

struct LoginView: View {
    
    @State private var viewModel = LoginViewModel()
    
    var body: some View {
        VStack {
            Text("Login")
                .font(.title)
                .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
            
            HStack {
                Image(systemName: "person.circle.fill")
                    .imageScale(.large)
                    .padding(.leading)

                TextField("Email", text: $viewModel.email)
                    .padding(.vertical)
                    .accentColor(.orange)
                    .autocapitalization(.none)
                }
                .background(
                  RoundedRectangle(cornerRadius: 16.0, style: .circular)
                    .foregroundColor(Color(.secondarySystemFill))
                )
                .padding()
            
            Button {
                Task {
                    try await viewModel.getMagicLink()
                }
            } label: {
                Text("Send Link")
            }
        }
    }
}

#Preview {
    LoginView()
}
