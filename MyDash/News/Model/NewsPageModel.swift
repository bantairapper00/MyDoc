//
//  NewsPageModel.swift
//  MyDash
//
//  Created by Abhishek on 18/01/25.
//

import Foundation

// MARK: - Welcome
struct NewsResult: Codable {
    let status: String?
    let totalResults: Int?
    let articles: [Article]?
}

// MARK: - Article
struct Article: Codable, Identifiable {
    let source: Source?
    let author: String?
    let title, description: String?
    let id: String
    let urlToImage: String?
    let publishedAt: String?
    let content: String?
    enum CodingKeys: String, CodingKey {
        case source,author, title, description
        case id = "url"
        case urlToImage, publishedAt, content
    }
    
}

// MARK: - Source
struct Source: Codable {
    let id: String?
    let name: String?
}

