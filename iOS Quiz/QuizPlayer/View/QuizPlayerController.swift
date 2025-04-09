//
//  ViewController.swift
//  iOS Quiz
//
//  Created by Rezaul Islam on 5/4/25.
//

import UIKit
import Combine

class QuizPlayerController: UIViewController {
    var cancellables = Set<AnyCancellable>()
    let quizViewModel: QuizPlayerViewModel = QuizPlayerViewModel()
    
    var score : Int = 0
    
    // Child View Controller
      private var currentQuestionIndex = 0
    
    // UI Components
        private let containerView: UIView = {
            let view = UIView()
            view.translatesAutoresizingMaskIntoConstraints = false
            view.backgroundColor = .systemBackground
            view.layer.cornerRadius = 16
            view.layer.shadowColor = UIColor.blue.cgColor
            view.layer.shadowOpacity = 0.2
            view.layer.shadowOffset = CGSize(width: 0, height: 5)
            view.layer.shadowRadius = 10
            return view
        }()
    
    
    private let progressLabel: UILabel = {
            let label = UILabel()
            label.translatesAutoresizingMaskIntoConstraints = false
            label.font = .systemFont(ofSize: 16, weight: .medium)
            label.textAlignment = .center
            return label
        }()
        
        private let activityIndicator: UIActivityIndicatorView = {
            let indicator = UIActivityIndicatorView(style: .large)
            indicator.translatesAutoresizingMaskIntoConstraints = false
            indicator.hidesWhenStopped = true
            return indicator
        }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        setupUI()
        quizViewModel.loadQuiz()
        
        bindviewModel(quizViewModel)
        activityIndicator.startAnimating()
    }
    
    
    func bindviewModel(_ viewModel: QuizPlayerViewModel) {
        viewModel.$questions
            .receive(on: DispatchQueue.main)
            .sink { [weak self] questions in
                print(questions)
                self?.activityIndicator.stopAnimating()
                self?.loadQuestion(at: self!.currentQuestionIndex)
                self?.updateProgressLabel()
            }.store(in: &cancellables)
    }
    
    
    private func loadQuestion(at index: Int) {
            guard index < quizViewModel.questions.count else {
                showQuizEndedAlert(score: score, outOf: index)
                return
            }
            
            let question = quizViewModel.questions[index]
            
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
            
            // Set next question callback
            newQuestionVC.onNextQuestion = { [weak self] in
                guard let self = self else { return }
                self.currentQuestionIndex += 1
                self.loadQuestion(at: self.currentQuestionIndex)
                self.updateProgressLabel()
            }
        newQuestionVC.onScorePlus = { [weak self] in
            guard let self = self else { return }
            score += 1
        }
        }
        
        private func updateProgressLabel() {
            progressLabel.text = "Question \(currentQuestionIndex + 1) of \(quizViewModel.questions.count)"
        }
        
    
    private func setupUI() {
            title = "iOS Quiz"
            view.backgroundColor = .systemBackground
            
            view.addSubview(progressLabel)
            view.addSubview(containerView)
            view.addSubview(activityIndicator)
            
            NSLayoutConstraint.activate([
                progressLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
                progressLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
                progressLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
                
                containerView.topAnchor.constraint(equalTo: progressLabel.bottomAnchor, constant: 20),
                containerView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
                containerView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
                containerView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20),
                
                activityIndicator.centerXAnchor.constraint(equalTo: view.centerXAnchor),
                activityIndicator.centerYAnchor.constraint(equalTo: view.centerYAnchor)
            ])
        }
    
    private func showQuizEndedAlert(score: Int, outOf: Int) {
        let alertController = UIAlertController(
            title: "Quiz Ended",
            message: "Nice job! You scored \(score)/\(outOf). Try again next time!. 😄🎉",
            preferredStyle: .alert
        )
        
        let tryAgainAction = UIAlertAction(title: "Try Again", style: .default) {[weak self] action in
            self?.score = 0
            self?.currentQuestionIndex = 0
            self?.loadQuestion(at: 0)
            
        }
        
        let exitAction = UIAlertAction(title: "Exit Quiz", style: .destructive){_ in
            exit(0)
        }
        
        alertController.addAction(tryAgainAction)
        alertController.addAction(exitAction)
        present(alertController, animated: true)
    }


}


#Preview{
    QuizPlayerController()
}
