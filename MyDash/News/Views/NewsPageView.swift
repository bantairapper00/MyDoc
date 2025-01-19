//
//  NewsPageView.swift
//  MyDash
//
//  Created by Abhishek on 17/01/25.
//

import SwiftUI

struct NewsPageView: View {
    
    @ObservedObject var viewModel: NewsPageVIewModel
    @State private var selectedArticle: Article?
    var body: some View {
        NavigationView {
            VStack(spacing: 0) {
                CategoryListView()
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
                .listStyle(.plain)
                .sheet(item: $selectedArticle) {
                    if let url = URL(string: $0.id) {
                        SafariView(url: url)
                            .edgesIgnoringSafeArea(.bottom)
                    }
                    
                }
                .task {
                    do {
                        try await viewModel.fetchNewsArticles()
                    } catch {
                        debugPrint(error.localizedDescription)
                    }
                }
                .navigationTitle("Today's Highlights")
                .navigationBarTitleDisplayMode(.inline)
            }
        }
        
        .navigationBarHidden(false)
    }
}

#Preview {
    NewsPageView(viewModel: NewsPageVIewModel())
}
