//
//  TabData.swift
//  MyDash
//
//  Created by Abhishek on 16/01/25.
//

import Foundation

enum TabsData: Int, CaseIterable {
    case about = 0, document, news, anime, stocks
    
    var tabImage: String {
        switch self {
        case .about:
            return "person.crop.circle"
        case .document:
            return "doc.text"
        case .news:
            return "newspaper.fill"
        case .anime:
            return "leaf"
        case .stocks:
            return "chart.line.uptrend.xyaxis"
        }
    }
    
    var tabName: String {
        switch self {
        case .about:
            return "About"
        case .document:
            return "Document"
        case .news:
            return "News"
        case .anime:
            return "Anime"
        case .stocks:
            return "Stocks"
        }
    }
    
    var index: Int {
        return TabsData.allCases.firstIndex(of: self) ?? 0
    }
}
