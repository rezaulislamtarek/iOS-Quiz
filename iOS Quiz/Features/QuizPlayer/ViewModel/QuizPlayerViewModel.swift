//
//  QuizPlayerViewModel.swift
//  iOS Quiz
//
//  Created by Rezaul Islam on 5/4/25.
//

import Foundation
import Combine

final class QuizPlayerViewModel {
    @Published var questions: [Question] = []
    
    private var cancellables = Set<AnyCancellable>()
    
    func loadQuiz(topic : String){
        loadJSON(filename: topic, as: Questions.self)
            .sink { com in
                switch com {
                case .finished:
                    print("Finished")
                case .failure(let error):
                    print(error.localizedDescription)
                }
            } receiveValue: { [weak self] response in
                self?.questions = response.questions
            }
            .store(in: &cancellables)
    }
}
