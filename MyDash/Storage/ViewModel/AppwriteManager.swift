//
//  Untitled.swift
//  MyDash
//
//  Created by Abhishek on 31/03/25.
//

import Appwrite

class AppwriteManager {
    static let shared = AppwriteManager()

    let client: Client
    let storage: Storage

    init() {
        client = Client()
            .setEndpoint("https://cloud.appwrite.io/v1") // Your Appwrite endpoint
            .setProject("67e937e8002efcd4a7cf")          // Your Project ID
            .setSelfSigned(true)                         // For dev mode

        storage = Storage(client)
    }
}
