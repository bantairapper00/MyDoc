//
//  LoginView.swift
//  MyDash
//
//  Created by Abhishek on 23/02/25.
//

import SwiftUI

struct LoginView: View {
    @State private var email: String = ""
    @State private var password: String = ""
    @EnvironmentObject var viewModel: AuthViewModel
    
    var body: some View {
        
        NavigationStack {
            GeometryReader {_ in 
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
                        InputVIew(text: $password, title: "Password", placeholder: "Password", isSecureTextEntry: true)
                        
                    }
                    .padding(.horizontal)
                    .padding(.top, 24)
                    
                    // sign in button
                    Button {
                        Task {
                            try await viewModel.signIn(withEmail: email, password: password)
                        }
                    } label: {
                        HStack {
                            Text("SIGN IN")
                                .fontWeight(.semibold)
                            Image(systemName: "arrow.right")
                        }
                        .foregroundStyle(.white)
                        .frame(width: UIScreen.main.bounds.width - 32, height: 48)
                    }
                    .background(Color.pink)
                    .cornerRadius(10)
                    .padding(.top, 2)
                    .padding(.bottom, 30)
                    
                    // sign up button
                    NavigationLink {
                        RegistrationView()
                            .navigationBarBackButtonHidden(true)
                    } label: {
                        HStack(spacing: 3) {
                            Text("Dont have an account?")
                            Text(" Sign Up")
                                .fontWeight(.bold)
                        }
                        .font(.system(size: 14))
                        .foregroundColor(.pink)
                    }
                }
            }
            .padding(.top, 60)
            .ignoresSafeArea(.keyboard)
        }
        
    }
}

#Preview {
    LoginView()
}
