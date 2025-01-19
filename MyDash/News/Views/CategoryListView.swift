//
//  CategoryListView.swift
//  MyDash
//
//  Created by Abhishek on 19/01/25.
//

import SwiftUI

struct CategoryListView: View {
    var body: some View {
        VStack {
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 2) {
                    ForEach(Categories.allCases, id: \.self) { category in
                        Text(category.text)
                            .font(.headline)
                            .padding()
                            .frame(height: 40)
                            .background(Color.black)
                            .foregroundColor(.white)
                            .cornerRadius(15)
                            .padding(.horizontal, 5)
                            .onTapGesture {
                                
                            }
                    }
                }
                .frame(height: 60)
            }
            
        }
    }
}

#Preview {
    CategoryListView()
}
