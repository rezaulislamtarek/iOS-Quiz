//
//  Questions.swift
//  iOS Quiz
//
//  Created by Rezaul Islam on 5/4/25.
//

import Foundation

struct Questions : Codable {
    let questions : [Question]
}

struct Question : Codable {
    let id : Int
    let question : String
    let options : [String]
    let answer : String
        var explanation : String?
    
    static let moc = Question(
        id: 1,
        question: "What programming language is primarily used for iOS app development?",
        options: [ "Java", "Kotlin", "Swift", "C#"],
        answer: "Swift", explanation: "Exp"
    )
}

 
