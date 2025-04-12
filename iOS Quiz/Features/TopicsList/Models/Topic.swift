//
//  Topic.swift
//  iOS Quiz
//
//  Created by Rezaul Islam on 12/4/25.
//
import Foundation

struct Topic: Identifiable, Hashable {
    let id = UUID()
    let name: String
    let symbol: String
}

extension Topic {
    static let allTopics: [Topic] = [
        Topic(name: "Swift Concurrency", symbol: "clock.arrow.2.circlepath"),
        Topic(name: "SwiftUI", symbol: "rectangle.3.offgrid.bubble.left"),
        Topic(name: "UIKit", symbol: "square.stack.3d.down.right"),
        Topic(name: "Actors", symbol: "person.3.sequence"),
        Topic(name: "Combine", symbol: "arrow.triangle.merge"),
        Topic(name: "Core Data", symbol: "cylinder.split.1x2"),
        Topic(name: "Networking", symbol: "network"),
        Topic(name: "Multithreading", symbol: "arrow.triangle.branch"),
        Topic(name: "Animations", symbol: "sparkles"),
        Topic(name: "Accessibility", symbol: "figure.walk.circle"),
        Topic(name: "Testing", symbol: "checkmark.shield"),
        Topic(name: "Debugging", symbol: "ladybug"),
        Topic(name: "App Lifecycle", symbol: "app.badge.checkmark"),
        Topic(name: "Memory Management", symbol: "memorychip"),
        Topic(name: "Async/Await", symbol: "arrow.triangle.2.circlepath"),
        Topic(name: "Protocols", symbol: "p.circle"),
        Topic(name: "Generics", symbol: "g.circle"),
        Topic(name: "MVVM", symbol: "rectangle.connected.to.line.below"),
        Topic(name: "Dependency Injection", symbol: "drop.triangle"),
        Topic(name: "APIs", symbol: "arrow.up.right.square")
    ]
}
