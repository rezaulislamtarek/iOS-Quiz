//
//  ViewController.swift
//  iOS Quiz
//
//  Created by Rezaul Islam on 5/4/25.
//

import UIKit
import Combine

class QuizPlayerController: UIViewController {
    // MARK: - Properties
    private var cancellables = Set<AnyCancellable>()
    private let quizViewModel: QuizPlayerViewModel
    
    private var score : Int = 0
    private var currentQuestionIndex = 0
    private var currentQuestionVC : QuestionViewController?
    
    
    // MARK: - UI Components
    private let containerView: UIView = .createContaineView()
    private let progressLabel: UILabel = .createLabel()
    private let activityIndicator: UIActivityIndicatorView = .createLoadingIndicator()
    
    
    // MARK: - Initialization
    init(viewModel : QuizPlayerViewModel = QuizPlayerViewModel()){
        self.quizViewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Lifecycle methods
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        startQuiz()
        bindviewModel(quizViewModel)
    }
    
    private func startQuiz() {
        activityIndicator.startAnimating()
        quizViewModel.loadQuiz()
    }
    
    private func restartQuiz() {
        score = 0
        currentQuestionIndex = 0
        loadQuestion(at: currentQuestionIndex)
        updateProgressLabel()
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
        if currentQuestionIndex + 1 <= quizViewModel.questions.count {
            progressLabel.text = "Question \(currentQuestionIndex + 1) of \(quizViewModel.questions.count)"
        }
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
    
    private func createCustomAlert(
        title : String,
        message :String,
        tryAgainAction : @escaping () -> Void,
        exitAction : @escaping () -> Void,
    ) -> UIAlertController{
        let aleartController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        aleartController.addAction(UIAlertAction(title: "Try again", style: .default){ _ in tryAgainAction() })
        aleartController.addAction(UIAlertAction(title: "Exit Quiz", style: .destructive){ _ in exitAction() })
        
        return aleartController
    }
    
    
    private func showQuizEndedAlert(score: Int, outOf: Int) {
    
        let aleartController = createCustomAlert(
            title: "Quiz Ended",
            message: "Nice job! You scored \(score)/\(outOf). Try again next time!. 😄🎉",
            tryAgainAction: { [weak self] in
                self?.restartQuiz()
            },
            exitAction: {
                exit(0)
            })
        
        present(aleartController, animated: true)
    }
    
    
}


#Preview{
    QuizPlayerController()
}
