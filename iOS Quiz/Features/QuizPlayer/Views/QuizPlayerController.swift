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
    
    
    // MARK: - UI Components
    let containerView: UIView = .createContaineView()
    let progressLabel: UILabel = .createLabel()
    let activityIndicator: UIActivityIndicatorView = .createLoadingIndicator()
    
    
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
        navigationController?.navigationBar.prefersLargeTitles = false
        setupUI()
        startQuiz()
        bindviewModel(quizViewModel)
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
    
}


#Preview{
    QuizPlayerController()
}
