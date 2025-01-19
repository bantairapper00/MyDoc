//
//  SafariView.swift
//  MyDash
//
//  Created by Abhishek on 19/01/25.
//

import SwiftUI
import SafariServices

struct SafariView: UIViewControllerRepresentable {
    
    let url: URL
    
    func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) {
    }
    
   
    func makeUIViewController(context: Context) -> some SFSafariViewController {
        SFSafariViewController(url: url)
    }
    

}
