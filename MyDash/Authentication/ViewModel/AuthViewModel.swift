//
//  AuthViewModel.swift
//  MyDash
//
//  Created by Abhishek on 26/03/25.
//

import Foundation
import FirebaseAuth
import FirebaseFirestore

@MainActor
class AuthViewModel: ObservableObject {
    @Published var userSession: FirebaseAuth.User?
    @Published var currentUser: User?
    
    init() {
        self.userSession = Auth.auth().currentUser
        
        Task {
            try await fetchUser()
        }
    }
    
    func signIn(withEmail email: String, password: String) async throws {
        do {
            let result = try await Auth.auth().signIn(withEmail: email, password: password)
            userSession = result.user
            try await fetchUser()
        }
        catch {
            print("Debug: Failed to sign in: \(error.localizedDescription)")
        }
    }
    
    func createUser(withEmail email: String, password: String, fullname: String) async throws {
        do {
            let result = try await Auth.auth().createUser(withEmail: email, password: password)
            self.userSession = result.user
            let user = User(id: result.user.uid, fullname: fullname, email: email)
            guard let encodedUser = try? Firestore.Encoder().encode(user) else {
                return
            }
            try await Firestore.firestore().collection("users").document(result.user.uid).setData(encodedUser)
            try await fetchUser()
        } catch {
            print("Debug: Failed to create user: \(error.localizedDescription)")
        }
    }
    
    func signOut() {
        do {
            try Auth.auth().signOut()
            userSession = nil
            currentUser = nil
        } catch {
            print("Failed to sign out with error: \(error.localizedDescription)")
        }
    }
    
    func deleteAccount() {
        
    }
    
    func fetchUser() async throws {
        do {
            guard let uid = userSession?.uid else {
                return
            }
            let snapshot = try await Firestore.firestore().collection("users").document(uid).getDocument()
            self.currentUser = try snapshot.data(as: User.self)
        } catch {
            print("Not able to fetch user data")
        }
    }
}
