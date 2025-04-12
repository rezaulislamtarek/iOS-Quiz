//
//  TopicViewModel.swift
//  iOS Quiz
//
//  Created by Rezaul Islam on 12/4/25.
//
import Combine
final class TopicViewModel {
    @Published var topicList: [Topic] = []
    
    init () {
        fetchTopic()
    }
    
    private func fetchTopic() {
        topicList = Topic.allTopics
    }
}
