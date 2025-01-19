//
//  NewsRowView.swift
//  MyDash
//
//  Created by Abhishek on 18/01/25.
//

import SwiftUI

struct NewsRowView: View {
    
    @ObservedObject var viewModel: NewsPageVIewModel
    var articles: Article

    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            AsyncImage(url: URL(string: articles.urlToImage ?? "")) { phase in
                switch phase {
                case .empty:
                    HStack {
                        Spacer()
                        ProgressView()
                        Spacer()
                    }
                case .success(let image):
                    image
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                case .failure(_):
                    HStack {
                        Spacer()
                        Image(systemName: "photo")
                        Spacer()
                    }
                @unknown default:
                    fatalError()
                }
            }
            .frame(minHeight: 200, maxHeight: 300)
            .background(Color.gray.opacity(0.3))
            
            VStack(alignment: .leading, spacing: 8) {
                Text(articles.title ?? "")
                    .font(.headline)
                    .lineLimit(3)
                Text(articles.description ?? "")
                    .font(.subheadline)
                    .lineLimit(2)
                
                HStack {
                    Text("\(articles.author ?? "") - \(viewModel.relativeDateString(from: articles.publishedAt ?? ""))")
                        .lineLimit(1)
                        .font(.caption)
                        .foregroundColor(.secondary)
                    Spacer()
                    
                    Button(action: {
                        
                    }, label: {
                        Image(systemName: "safari")
                    })
                    .buttonStyle(.bordered)
                    Button(action: {
                        if let url = URL(string: articles.id) {
                            ShareSheet().presentShareSheet(url: url)
                        } else {
                            debugPrint("Invalid Share URL")
                        }
                    }, label: {
                        Image(systemName: "square.and.arrow.up")
    
                    })
                    .buttonStyle(.bordered)
                    
                }
            }
            .padding([.horizontal, .bottom])
        }
    }		
}

#Preview {
    NewsRowView(viewModel: NewsPageVIewModel(), articles: Article(source: Source(id: "123", name: ""), author: "Todd Feathers", title: "The First Bitcoin President? Tracing Trump’s Crypto Connections", description: "Crypto execs funneled millions in donations to swing this election, and now their man is in charge. Here’s how Donald Trump’s “crypto cabinet” could shape the next four years.", id:  "https://www.wired.com/story/mapping-donald-trump-crypto-connections/", urlToImage: "https://media.wifred.com/photos/67815aa7ced74e457dc3a71e/191:100/w_1280,c_limit/011025_Trumps-Crypto-Cabinet.jpg", publishedAt: "2025-01-16T21:05:53Z", content: "The cryptocurrency industry is lobbying President-Elect Donald Trump and incoming administration officials to buy billions of dollars worth of bitcoin for a national crypto stockpile, according to re… [+2619 chars]"))
}
