//
//  MyDashApp.swift
//  MyDash
//
//  Created by Abhishek on 16/01/25.
//

import SwiftUI
import Firebase

@main
struct MyDashApp: App {
    @StateObject var appState = AppState()
    @StateObject var authViewModel = AuthViewModel()
    
    init() {
        FirebaseApp.configure()
    }
    
    var body: some Scene {
        WindowGroup {
            LaunchView()
                .environmentObject(appState)
                .environmentObject(authViewModel)
                .background(Color.gray.opacity(0.01))
            
        }
    }
}
