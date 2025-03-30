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
    private let bucketID = "67e93a79001bbff8cdd0"
    @EnvironmentObject var viewModel: AuthViewModel
    
    /// Uploads image to Appwrite using `InputFile`
    func uploadImage(_ image: UIImage, userId: String?) async throws {
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
            let result = try await storage.createFile(
                bucketId: bucketID,
                fileId: fileId,
                file: file
            )
            
            /// Fetch the image URL
            await getFileURL(fileId: result.id)

        } catch {
            print("Upload failed: \(error.localizedDescription)")
        }
    }

    func getImages(userID: String?) async throws -> [UIImage] {
        guard let fieldID = userID else {
            return []
        }
        
        let fileList = try? await storage.listFiles(bucketId: bucketID)
        
        let matchingFiles = fileList?.files.filter { $0.name.contains(fieldID) } ?? []
        
        print("matching Files: \(matchingFiles)")
        
        var images: [UIImage] = []
        
        for file in matchingFiles {
            if let byteBuffer = try? await storage.getFilePreview(bucketId: bucketID, fileId: file.id) {
                let imageData = Data(byteBuffer.readableBytesView)
                
                if let image = UIImage(data: imageData) {
                    images.append(image)
                }
            }
        }
        
        print(images)
        
        return images
    }

    
    /// Fetches the image URL from Appwrite
    func getFileURL(fileId: String) async {
        let urlString = "https://cloud.appwrite.io/v1/storage/buckets/YOUR_BUCKET_ID/files/\(fileId)/view?project=YOUR_PROJECT_ID"

        if let url = URL(string: urlString) {
            self.uploadedImageURL = url
        }
    }
}
