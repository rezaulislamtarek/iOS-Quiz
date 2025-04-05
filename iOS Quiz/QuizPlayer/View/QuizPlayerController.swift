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

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        quizViewModel.loadQuiz()
        
        bindviewModel(quizViewModel)
    }
    
    
    func bindviewModel(_ viewModel: QuizPlayerViewModel) {
        viewModel.$questions
            .receive(on: DispatchQueue.main)
            .sink { [weak self] questions in
                print(questions)
            }.store(in: &cancellables)
    }


}

