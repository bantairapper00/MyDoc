//
//  CategoryListView.swift
//  MyDash
//
//  Created by Abhishek on 19/01/25.
//

import SwiftUI

struct CategoryListView: View {
    @Binding var selectedCategory: String
    var body: some View {
        VStack {
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 2) {
                    ForEach(Categories.allCases, id: \.self) { category in
                        Text(category.rawValue)
                            .font(.headline)
                            .padding()
                            .frame(height: 40)
                            .background(Color.black)
                            .foregroundColor(.white)
                            .cornerRadius(15)
                            .padding(.horizontal, 5)
                            .onTapGesture {
                                selectedCategory = category.rawValue
                            }
                    }
                    .frame(height: 60)
                }
                
            }
        }
    }
}

#Preview {
    CategoryListView(selectedCategory: .constant("general"))
}
