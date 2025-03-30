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
                VStack {
                    if let image = selectedImage {
                        Image(uiImage: image)
                            .resizable()
                            .scaledToFit()
                            .frame(width: 300, height: 300)
                            .cornerRadius(15)
                            .padding()
                        
                        Button("Upload to Appwrite") {
                            Task {
                                try await viewModel.uploadImage(
                                    image,
                                    userId: loginViewModel.currentUser?.id)
                            }
                        }
                        .padding()
                        .foregroundColor(.white)
                        .background(Color.blue)
                        .cornerRadius(10)
                    } else {
                        Text("Select an Image")
                            .foregroundColor(.gray)
                    }
                    
                    PhotosPicker(
                        selection: $selectedItem,
                        matching: .images,
                        photoLibrary: .shared()
                    ) {
                        Text("Pick Image")
                            .font(.title3)
                            .foregroundColor(.white)
                            .padding()
                            .background(Color.green)
                            .cornerRadius(10)
                    }
                    .onChange(of: selectedItem) { newItem in
                        Task {
                            await loadImage(from: newItem)
                        }
                    }
                    
                    if let uploadedURL = viewModel.uploadedImageURL {
                        Text("Image URL: \(uploadedURL.absoluteString)")
                            .foregroundColor(.blue)
                            .padding()
                        
                        AsyncImage(url: uploadedURL) { image in
                            image.resizable()
                                .scaledToFit()
                                .frame(width: 200, height: 200)
                                .cornerRadius(10)
                        } placeholder: {
                            ProgressView()
                        }
                    }
                }
                .padding()
            }
        } else {
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
                    Button(action: {
                        print("Log in tapped")
                    }) {
                        Text("Log in")
                            .fontWeight(.semibold)
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(Color.pink)
                            .foregroundColor(.white)
                            .cornerRadius(30)
                            .shadow(color: .gray.opacity(0.5), radius: 4, x: 0, y: 2)
                    }
                    
                    Button(action: {
                        print("Sign up tapped")
                    }) {
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
