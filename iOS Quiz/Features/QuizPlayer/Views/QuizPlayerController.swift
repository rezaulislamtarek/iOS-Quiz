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
    let quizViewModel: QuizPlayerViewModel
    var score : Int = 0
    var currentQuestionIndex = 0
    var currentQuestionVC : QuestionViewController?
    let topic : String
    let remainigTime : Int = 5
    
    
    // MARK: - UI Components
    let containerView: UIView = .createContaineView()
    let progressLabel: UILabel = .createLabel()
    let activityIndicator: UIActivityIndicatorView = .createLoadingIndicator()
    let timerLabel : UILabel = .createLabel()
    
    
    // MARK: - Initialization
    init(viewModel : QuizPlayerViewModel = QuizPlayerViewModel(), topic : String){
        self.quizViewModel = viewModel
        self.topic = topic
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Lifecycle methods
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.prefersLargeTitles = false
        setupUI()
        timerLabel.text = "00:00"
        timerLabel.textColor = .white
        startQuiz()
        bindviewModel(quizViewModel)
        startTimer()
    }
    
    private func startTimer() {
        quizViewModel.setRemainingTime(remainigTime)
        timerLabel.font = UIFont.monospacedDigitSystemFont(ofSize: 40, weight: .medium)
        timerLabel.textAlignment = .center
        quizViewModel.startTimer()
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
        
        
        viewModel.$timeText
            .receive(on: DispatchQueue.main)
            .sink(receiveValue: { [weak self] timeText in
                self?.timerLabel.text = timeText
            })
            .store(in: &cancellables)
    }
    
}


#Preview{
    QuizPlayerController(topic: "Combine")
}
