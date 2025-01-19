//
//  Categories.swift
//  MyDash
//
//  Created by Abhishek on 19/01/25.
//

import Foundation

enum Categories: String, CaseIterable {
    case general
    case business
    case entertainment
    case health
    case science
    case sports
    case technology
    
    var text: String {
        if self == .general {
            return "Top Headlines"
        }
        return rawValue.capitalized
    }
}
