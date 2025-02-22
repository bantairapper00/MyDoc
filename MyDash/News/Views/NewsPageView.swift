//
//  NewsPageView.swift
//  MyDash
//
//  Created by Abhishek on 17/01/25.
//

import SwiftUI
import UIKit

struct NewsPageView: View {
    
    @ObservedObject var viewModel: NewsPageVIewModel
    @State private var selectedArticle: Article?
    @State var selectedCategory: String = "general"
    @State private var isShowingAlert = false

    var body: some View {
        NavigationView {
            VStack(spacing: 0) {
                CategoryListView(selectedCategory: $selectedCategory)
                    .onChange(of: selectedCategory) { _ in
                        viewModel.state = .isloading
                    }
                switch viewModel.state {
                case .isloading:
                    Spacer()
                    ProgressView()
                    Spacer()
                        .task {
                            await viewModel.fetchNewsArticles(category: selectedCategory, language: "en")
                            
                        }
                case .loaded:
                    List {
                        ForEach(viewModel.articles) {article in
                            if article.title != "[Removed]" {
                                NewsRowView(viewModel: NewsPageVIewModel(), articles: article)
                                    .onTapGesture {
                                        selectedArticle = article
                                    }
                            }
                        }
                        .listRowInsets(.init(top: 0, leading: 0, bottom: 0, trailing: 0))
                        .listRowSeparator(.hidden)
                    }
                    .id(selectedCategory)
                    .listStyle(.plain)
                    .sheet(item: $selectedArticle) {
                        if let url = URL(string: $0.id) {
                            SafariView(url: url)
                                .edgesIgnoringSafeArea(.bottom)
                        }
                        
                    }
                   
                case .error(let error):
                    VStack(alignment: .center, spacing: 40) {
                        Spacer()
                        Image(systemName: "exclamationmark.triangle.fill")
                            .foregroundColor(.red)
                            .font(.system(size: 90))
                        Text(error)
                            .font(.headline)
                            .foregroundStyle(.secondary)
                            .padding(.horizontal, 35)
                            .multilineTextAlignment(.center)
                            .padding(.bottom, 60)
                        Button(action: {
                            viewModel.state = .isloading
                        }, label: {
                            Text("Try Again")
                                .padding(EdgeInsets(top: 6, leading: 40, bottom: 6, trailing: 40))
                                .font(.system(size: 15, weight: .bold))
                                .foregroundColor(.white)
                        })
                        .buttonStyle(.bordered)
                        .background(.blue)
                        Spacer()
                        Spacer()
                    }
                }
            }
            .navigationTitle("Today's Highlights")
            .navigationBarTitleDisplayMode(.inline)
        }
        .onAppear {
            let appearance = UINavigationBarAppearance()
                appearance.configureWithOpaqueBackground() // Use opaque background for solid color
                appearance.backgroundColor = UIColor.white // Set the solid background color
                appearance.titleTextAttributes = [.foregroundColor: UIColor.black] // Optional: Set title text color
                UINavigationBar.appearance().standardAppearance = appearance
                UINavigationBar.appearance().scrollEdgeAppearance = appearance
        }
    }
}

#Preview {
    NewsPageView(viewModel: NewsPageVIewModel())
}
