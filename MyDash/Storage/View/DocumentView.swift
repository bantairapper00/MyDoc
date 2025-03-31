//
//  DocumentView.swift
//  MyDash
//
//  Created by Abhishek on 30/03/25.
//

import SwiftUI
import PhotosUI

struct DocumentView: View {
    @StateObject private var viewModel = DocumentUploadViewModel()
    @State private var selectedItem: PhotosPickerItem? = nil
    @State private var selectedImage: UIImage? = nil
    @EnvironmentObject var loginViewModel: AuthViewModel
    
    var body: some View {
        if loginViewModel.currentUser != nil {
            ScrollView {
                ImagePreviewView(viewModel: viewModel)
            }
            .overlay(
                PhotosPicker(
                    selection: $selectedItem,
                    matching: .images,
                    photoLibrary: .shared()
                ) {
                    Image(systemName: "plus")
                        .foregroundColor(.white)
                        .padding()
                        .background(Color.blue)
                        .clipShape(Circle())
                        .shadow(radius: 5)
                }
                    .padding(20)
                    .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .bottomTrailing)
                    .onChange(of: selectedItem) { newItem in
                        Task {
                            await loadImage(from: newItem)
                        }
                    }
                    .onChange(of: selectedImage) { _ in
                        if let selectedImage = selectedImage {
                            Task{
                                try await viewModel.uploadImage(
                                    selectedImage,
                                    userId: loginViewModel.currentUser?.id)
                            }
                        }
                    }
            )
        } else {
            NavigationStack {
                VStack(alignment: .center, spacing: 30) {
                    
                    Image(systemName: "flame.fill")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 100, height: 100)
                        .foregroundColor(.pink)
                    
                    Text("You are not logged in")
                        .font(.title)
                        .fontWeight(.semibold)
                        .foregroundColor(.pink)
                    
                    Text("Login to access all your saved documents")
                        .font(.subheadline)
                        .foregroundColor(.gray)
                        .multilineTextAlignment(.center)
                        .padding(.horizontal, 30)
                    
                    VStack(spacing: 15) {
                        NavigationLink {
                            LoginView()
                        } label: {
                            Text("Log in")
                                .fontWeight(.semibold)
                                .frame(maxWidth: .infinity)
                                .padding()
                                .background(Color.pink)
                                .foregroundColor(.white)
                                .cornerRadius(30)
                                .shadow(color: .gray.opacity(0.5), radius: 4, x: 0, y: 2)
                        }
                        
                        NavigationLink {
                            RegistrationView()
                        } label:{
                            Text("Sign Up")
                                .fontWeight(.semibold)
                                .frame(maxWidth: .infinity)
                                .padding()
                                .background(Color.white)
                                .foregroundColor(.pink)
                                .cornerRadius(30)
                                .overlay(
                                    RoundedRectangle(cornerRadius: 30)
                                        .stroke(Color.pink, lineWidth: 2)
                                )
                                .shadow(color: .gray.opacity(0.3), radius: 4, x: 0, y: 2)
                        }
                    }
                    .padding(.horizontal, 40)
                    
                    Spacer()
                }
                .padding(.top, 60)
                .background(Color(.systemBackground))
            }
        }
    }
    
    /// Asynchronously loads the selected image
    private func loadImage(from item: PhotosPickerItem?) async {
        guard let item = item else { return }
        
        if let data = try? await item.loadTransferable(type: Data.self),
           let uiImage = UIImage(data: data) {
            selectedImage = uiImage
        }
    }
}

#Preview {
    DocumentView()
        .environmentObject(AuthViewModel())
}
