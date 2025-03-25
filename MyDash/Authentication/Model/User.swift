//
//  UserData.swift
//  MyDash
//
//  Created by Abhishek on 25/02/25.
//

import Foundation

struct User: Identifiable, Codable {
    var id: String
    var fullname: String
    var email: String
    
    var initials: String {
        let formatter = PersonNameComponentsFormatter()
        if let component = formatter.personNameComponents(from: fullname) {
            formatter.style = .abbreviated
            return formatter.string(from: component)
        }
        return ""
    }
}

extension User {
    static var Mock_User = User (
        id: NSUUID().uuidString,
        fullname: "Abhishek Kumar",
        email: "abhishek@gmail.com"
    )
}
