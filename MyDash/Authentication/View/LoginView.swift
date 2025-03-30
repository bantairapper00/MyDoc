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
                    Image(.myDash)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 200, height: 200)
                    
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
                    .background(Color.blue)
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
                    }
                    
                    Spacer()
                }
                .background(Color(red: 163/255, green: 162/255, blue: 158/255))
            }
            .ignoresSafeArea(.keyboard)
        }
        
    }
}

#Preview {
    LoginView()
}
