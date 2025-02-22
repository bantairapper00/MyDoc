//
//  NewsPageVIewMode.swift
//  MyDash
//
//  Created by Abhishek on 18/01/25.
//

import Foundation


class NewsPageVIewModel: ObservableObject {
    
    enum State {
        case isloading
        case loaded
        case error(String)
    }
    
    let networkManager = NetworkManager()
    @Published var articles: [Article] = []
    @Published var state: State = .isloading
    
    @MainActor
    func fetchNewsArticles(category: String, language: String) async {
        self.state = .isloading

        guard let url = URL(string: "https://newsapi.org/v2/everything?q=\(category)&sortBy=publishedAt&language=\(language)&apiKey=b0a3cd1716c54765bad0929866de5428") else {
            self.state = .error("Invalid URL")
            return
        }

        let resource = Resource<NewsResult>(
            url: url,
            method: .get([])
        )

        do {
            let result = try await networkManager.load(resource: resource)
            if let newsArticles = result.articles {
                self.articles = newsArticles
                self.state = .loaded
            } else {
                self.state = .error("No articles found in the response.")
            }
        } catch {
            self.state = .error("Error fetching news articles: \n\(error.localizedDescription)")
        }
    }
    
    
//    func loadJSON() {
//        guard let url = Bundle.main.url(forResource: "Data", withExtension: "json") else {
//            print("Failed to locate filename) in bundle.")
//            return
//        }
//        do {
//            let data = try Data(contentsOf: url)
//            let decodedData = try JSONDecoder().decode(NewsResult.self, from: data)
//            articles = decodedData.articles!
//        } catch {
//            print("Failed to decode filename): \(error)")
//        }
//    }
    
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
