//
//  ProfileView.swift
//  MyDash
//
//  Created by Abhishek on 24/02/25.
//

import SwiftUI

struct ProfileView: View {
    @EnvironmentObject var viewModel: AuthViewModel
    
    var body: some View {
        if let user = viewModel.currentUser {
            List {
                Section{
                    HStack {
                        Text(user.initials)
                            .font(.title)
                            .fontWeight(.semibold)
                            .foregroundColor(.white)
                            .frame(width: 72, height: 72)
                            .background(Color(.systemGray3))
                            .clipShape(Circle())
                        VStack(alignment: .leading, spacing: 4) {
                            Text(user.fullname)
                                .font(.subheadline)
                                .fontWeight(.semibold)
                                .padding(.top, 4)
                            
                            Text(user.email)
                                .font(.footnote)
                                .foregroundColor(.gray)
                        }
                        
                    }
                }
                
                Section("Account") {
                    Button {
                        viewModel.signOut()
                    } label: {
                        HStack {
                            Image(systemName: "arrow.left.circle.fill")
                                .foregroundColor(.red)
                            Text("Sign out")
                                .foregroundColor(.black)
                                .fontWeight(.medium)
                        }
                    }
                    
                    Button {
                        print("Delete account")
                    } label: {
                        HStack {
                            Image(systemName: "xmark.circle.fill")
                                .foregroundColor(.red)
                            Text("Delete")
                                .foregroundColor(.black)
                                .fontWeight(.medium)
                        }
                    }
                }
            }
        } else {
            EmptyView()
        }
    }
}

#Preview {
    ProfileView()
}
