//
//  ShareSheet.swift
//  MyDash
//
//  Created by Abhishek on 19/01/25.
//

import Foundation
import UIKit

struct ShareSheet {
    
    func presentShareSheet(url: URL) {
        let activityVC = UIActivityViewController(activityItems: [url], applicationActivities: nil)
        (UIApplication.shared.connectedScenes.first as? UIWindowScene)?
            .keyWindow?
            .rootViewController?
            .present(activityVC, animated: true)
    }
}
