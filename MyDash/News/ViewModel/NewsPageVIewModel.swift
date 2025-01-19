//
//  NewsPageVIewMode.swift
//  MyDash
//
//  Created by Abhishek on 18/01/25.
//

import Foundation

class NewsPageVIewModel: ObservableObject {
    
    let networkManager = NetworkManager()
    @Published var articles: [Article] = []
    
    func fetchNewsArticles() async throws {
        if let url = URL(string: "https://newsapi.org/v2/everything?q=tesla&from=2024-12-18&sortBy=publishedAt&apiKey=7b8ecda91d8b4619a5a0ce2da13c92c8") {
            let resource = Resource<NewsResult>(
                url: url,
                method: .get([])
            )
            let result = try await networkManager.load(resource: resource)
            if let newsArticles = result.articles {
                DispatchQueue.main.async {
                    self.articles = newsArticles
                }
            }
        }
    }
    func relativeDateString(from dateString: String) -> String {
        // Initialize an ISO8601DateFormatter to parse the string
        let isoFormatter = ISO8601DateFormatter()
        
        // Try to decode the string into a Date
        guard let publishedDate = isoFormatter.date(from: dateString) else {
            return "Invalid date"
        }
        
        // Initialize a RelativeDateTimeFormatter for human-readable relative date
        let relativeFormatter = RelativeDateTimeFormatter()
        relativeFormatter.unitsStyle = .full // You can also use `.short` or `.abbreviated`
        
        // Return the formatted string
        return relativeFormatter.localizedString(for: publishedDate, relativeTo: Date())
    }
}
