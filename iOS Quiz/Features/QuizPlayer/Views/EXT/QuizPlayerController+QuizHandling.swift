//
//  QuizPlayerController+QuizHandling.swift
//  iOS Quiz
//
//  Created by Rezaul Islam on 12/4/25.
//

import UIKit

extension QuizPlayerController {
    func startQuiz() {
        activityIndicator.startAnimating()
        quizViewModel.loadQuiz(topic: topic)
    }
    
    func restartQuiz() {
        score = 0
        currentQuestionIndex = 0
        loadQuestion(at: currentQuestionIndex)
        updateProgressLabel()
    }
    
    func loadQuestion(at index: Int) {
        
        guard index < quizViewModel.questions.count else {
            showQuizEndedAlert(score: score, outOf: index)
            
            return
        }
        
        let question = quizViewModel.questions[index]
        
        if let currentVC = currentQuestionVC {
            print("Current vc removed")
            currentVC.willMove(toParent: nil)
            currentVC.view.removeFromSuperview()
            currentVC.removeFromParent()
        }
        
        // Create and add new question view controller
        let newQuestionVC = QuestionViewController(question: question)
        addChild(newQuestionVC)
        containerView.addSubview(newQuestionVC.view)
        newQuestionVC.view.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            newQuestionVC.view.topAnchor.constraint(equalTo: containerView.topAnchor),
            newQuestionVC.view.leadingAnchor.constraint(equalTo: containerView.leadingAnchor),
            newQuestionVC.view.trailingAnchor.constraint(equalTo: containerView.trailingAnchor),
            newQuestionVC.view.bottomAnchor.constraint(equalTo: containerView.bottomAnchor)
        ])
        
        newQuestionVC.didMove(toParent: self)
        currentQuestionVC = newQuestionVC
        setUpCallbacks(qVC: newQuestionVC)
        
    }
    
    func setUpCallbacks(qVC : QuestionViewController) {
        // Set next question callback
        qVC.onNextQuestion = { [weak self] in
            guard let self = self else { return }
            self.currentQuestionIndex += 1
            self.loadQuestion(at: self.currentQuestionIndex)
            self.updateProgressLabel()
        }
        qVC.onScorePlus = { [weak self] in
            guard let self = self else { return }
            score += 1
        }
        
    }
    
    func updateProgressLabel() {
        if currentQuestionIndex + 1 <= quizViewModel.questions.count {
            progressLabel.text = "Question \(currentQuestionIndex + 1) of \(quizViewModel.questions.count)"
        }
    }
}
