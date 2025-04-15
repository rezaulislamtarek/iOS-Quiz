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
    @Published var timeText: String = "15:00"
    @Published var isFinished: Bool = false
    
    private var cancellables = Set<AnyCancellable>()
    private var timer : Timer?
    private var remainingTime : Int = 0
    
    func setRemainingTime(_ time: Int) {
        self.remainingTime = time * 60
    }
    
    func startTimer( ){
        updateTimeText()
        timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true, block: { [weak self] _ in
            guard let self = self else { return }
            if self.remainingTime > 0 {
                self.remainingTime -= 1
                self.updateTimeText()
            }else {
                self.timer?.invalidate()
                self.timer = nil
                self.isFinished = true
            }
        })
    }
    
    private func updateTimeText() {
            let minutes = remainingTime / 60
            let seconds = remainingTime % 60
            timeText = String(format: "%02d:%02d", minutes, seconds)
        }

        func stopTimer() {
            timer?.invalidate()
            timer = nil
        }
    
    
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
