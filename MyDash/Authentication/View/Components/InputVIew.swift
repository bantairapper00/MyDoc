//
//  InputVIew.swift
//  MyDash
//
//  Created by Abhishek on 24/02/25.
//

import SwiftUI

struct InputVIew: View {
    @Binding var text: String
    var title: String
    var placeholder: String
    var isSecureTextEntry: Bool = false
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text(title)
                .foregroundColor(.pink)
                .fontWeight(.semibold)
                .font(.footnote)
            if isSecureTextEntry {
                SecureField(placeholder, text: $text)
                    .font(.system(size: 14))
            }
            else {
                TextField(placeholder, text: $text)
                    .font(.system(size: 14))
            }
        }
        
        Divider()
            .background(.pink)
    }
}

#Preview {
    InputVIew(text: .constant(""), title: "Email Address", placeholder: "name@example.com")
}
