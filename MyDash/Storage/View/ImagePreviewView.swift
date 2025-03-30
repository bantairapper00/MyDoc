//
//  ImagePreviewView.swift
//  MyDash
//
//  Created by Abhishek on 31/03/25.
//

import SwiftUI

struct ImagePreviewView: View {
    @State private var images: [UIImage] = []
    @ObservedObject var viewModel: DocumentUploadViewModel
    @EnvironmentObject var loginViewModel: AuthViewModel
    
    var body: some View {
        ScrollView {
            VStack {
                if images.isEmpty {
                    Text("No images found")
                        .foregroundColor(.gray)
                        .padding()
                } else {
                    ForEach(0..<images.count, id: \.self) { index in
                        Image(uiImage: images[index])
                            .resizable()
                            .scaledToFit()
                            .frame(height: 200)
                            .cornerRadius(10)
                            .padding()
                    }
                }
            }
            .onAppear {
                Task {
                    do {
                        images = try await viewModel.getImages(userID: loginViewModel.currentUser?.id)
                    } catch {
                        print("Error loading images: \(error.localizedDescription)")
                    }
                }
            }
        }
    }
}

