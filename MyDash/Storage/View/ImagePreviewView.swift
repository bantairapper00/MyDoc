//
//  ImagePreviewView.swift
//  MyDash
//
//  Created by Abhishek on 31/03/25.
//

import SwiftUI

struct ImagePreviewView: View {
    @ObservedObject var viewModel: DocumentUploadViewModel
    @EnvironmentObject var loginViewModel: AuthViewModel
    
    var body: some View {
        VStack {
            LazyVGrid(columns: Array(repeating: .init(.flexible()), count: 2), spacing: 16) {
                ForEach(0..<viewModel.images.count, id: \.self) { index in
                    VStack {
                        Image(uiImage: viewModel.images[index])
                            .resizable()
                            .scaledToFit()
                            .frame(width: 100, height: 100)
                        // Action menu button
                        Button {
                            print("Options for ")
                        } label: {
                            Image(systemName: "ellipsis")
                                .foregroundColor(.gray)
                                .padding(.top, 5)
                        }
                    }
                    .padding()
                    .background(Color.white)
                    .cornerRadius(12)
                    .shadow(radius: 2)
                }
                
            }
            .padding()
        }
        .onAppear {
            Task {
                do {
                    viewModel.images = try await viewModel.getImages(userID: loginViewModel.currentUser?.id)
                } catch {
                    print("Error loading images: \(error.localizedDescription)")
                }
            }
        }
        
    }
}
