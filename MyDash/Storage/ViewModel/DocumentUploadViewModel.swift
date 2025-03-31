//
//  Untitled.swift
//  MyDash
//
//  Created by Abhishek on 30/03/25.
//

import SwiftUI
import Appwrite

@MainActor
class DocumentUploadViewModel: ObservableObject {
    private let storage = AppwriteManager.shared.storage
    @Published var uploadedImageURL: URL? = nil
    private let bucketID = "67eae0f20013797e69fb"
    @EnvironmentObject var viewModel: AuthViewModel
    @Published var images: [UIImage] = []
    /// Store fetched image IDs to avoid refetching
    private var fetchedImageIDs: Set<String> = []
    
    /// Uploads image to Appwrite using `InputFile`
    func uploadImage(_ image: UIImage, userId: String?) async throws {
        /// check user has a login user ID
        guard let userId = userId else {
            return
        }
        
        guard let imageData = image.jpegData(compressionQuality: 1) else {
            print("Failed to convert image to Data")
            return
        }

        let fileId = ID.unique()
        
        let filename = "\(userId)/image_\(fileId).jpg"
        
        do {
            /// Create an `InputFile` object
            let file = InputFile.fromData(imageData, filename: filename, mimeType: "image/jpeg")

            /// Upload the file
            _ = try await storage.createFile(
                bucketId: bucketID,
                fileId: fileId,
                file: file
            )
            
            print("Image uploaded successfully!")
            
            _ = try await getImages(userID: userId)

        } catch {
            print("Upload failed: \(error.localizedDescription)")
        }
    }

    func getImages(userID: String?) async throws -> [UIImage] {
        do {
            guard let fieldID = userID else {
                return []
            }
            
            let fileList = try await storage.listFiles(bucketId: bucketID)
            
            // Filter only new images
            let filteredFileList = fileList.files
                .filter { $0.name.contains(fieldID) && !fetchedImageIDs.contains($0.id) }
            
            
            for file in filteredFileList {
                print("print \(file.id)")
                if let byteBuffer = try? await storage.getFilePreview(bucketId: bucketID, fileId: file.id) {
                    let imageData = Data(byteBuffer.readableBytesView)
                    
                    // Add only new image and its ID
                    if let image = UIImage(data: imageData) {
                        print("image: \(image)")
                        images.append(image)
                        fetchedImageIDs.insert(file.id)  // Track fetched image ID
                    }
                }
            }
            
            return images
        } catch {
            print("Failed to get images: \(error)")
            return []
        }
    }
}
