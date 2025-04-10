//
//  LaunchScreen.swift
//  MyDash
//
//  Created by Abhishek on 09/04/25.
//

import SwiftUI

struct LaunchView: View {
    
    @EnvironmentObject var authViewModel: AuthViewModel
    @State private var moveToNextScreen: Bool = false
    var body: some View {
        ZStack {
            if moveToNextScreen {
                TabBarView()
            } else {
                LottieView(animationname: "loading")
            }
        }
        .task {
            if moveToNextScreen == false {
                do {
                    try await authViewModel.fetchUser()
                } catch {
                    print("Error fetching user: \(error)")
                }
                withAnimation{
                    self.moveToNextScreen = true
                }
            }
        }
    }
}

#Preview {
    LaunchView()
}
