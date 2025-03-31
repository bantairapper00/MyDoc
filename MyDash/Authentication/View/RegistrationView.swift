//
//  RegistrationView.swift
//  MyDash
//
//  Created by Abhishek on 24/02/25.
//

import SwiftUI

struct RegistrationView: View {
    @State private var email: String = ""
    @State private var name: String = ""
    @State private var confirmPassword: String = ""
    @State private var password: String = ""
    @Environment(\.dismiss) private var dismiss
    @EnvironmentObject var appState: AppState
    @EnvironmentObject var viewModel: AuthViewModel

    var body: some View {
        NavigationStack {
            VStack {
                // image
                Image(systemName: "flame.fill")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 100, height: 100)
                    .foregroundColor(.pink)
                
                // sign in form
                VStack(spacing: 24) {
                    InputVIew(text: $email, title: "Email Address", placeholder: "name@example.com")
                        .autocapitalization(.none)
                    InputVIew(text: $name, title: "Full Name", placeholder: "Enter your name")
                    InputVIew(text: $password, title: "Password", placeholder: "Enter your password", isSecureTextEntry: true)
                    InputVIew(text: $confirmPassword, title: "Confirm password", placeholder: "Confirm your password", isSecureTextEntry: true)
                }
                .padding(.horizontal)
                .padding(.top, 24)
                
                // sign in button
                Button {
                    Task {
                        try await viewModel.createUser(withEmail: email, password: password, fullname: name)
                    }
                } label: {
                    HStack {
                        Text("SIGN UP")
                            .fontWeight(.semibold)
                        Image(systemName: "arrow.right")
                    }
                    .foregroundStyle(.white)
                    .frame(width: UIScreen.main.bounds.width - 32, height: 48)
                }
                .background(Color.pink)
                .cornerRadius(10)
                .padding(.top, 24)
                .padding(.bottom, 30)
                
                // sign up button
                Button {
                    appState.hideTabBar = false
                    dismiss()
                } label: {
                    HStack(spacing: 3) {
                        Text("Already have an account?")
                        Text(" Sign In")
                            .fontWeight(.bold)
                    }
                    .foregroundColor(.pink)
                    .font(.system(size: 14))
                }
                
                Spacer()
            }
            .padding(.top, 60)
            .onAppear {
                appState.hideTabBar = true
            }
            .onDisappear {
                appState.hideTabBar = false
            }
        }
        .toolbar(.hidden, for: .tabBar)
    }
}

#Preview {
    RegistrationView()
        .environmentObject(AppState())
}
