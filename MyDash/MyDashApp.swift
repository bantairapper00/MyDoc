//
//  MyDashApp.swift
//  MyDash
//
//  Created by Abhishek on 16/01/25.
//

import SwiftUI

@main
struct MyDashApp: App {
    @StateObject var appState = AppState()
    var body: some Scene {
        WindowGroup {
            TabBarView()
                .environmentObject(appState)
        }
    }
}
