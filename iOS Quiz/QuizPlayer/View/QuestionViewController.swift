//
//  QuestionViewController.swift
//  iOS Quiz
//
//  Created by Rezaul Islam on 5/4/25.
//

import UIKit

class QuestionViewController: UIViewController {
    var score : Int = 0
    
    private let questionLabel: UILabel = {
        let label = UILabel()
        label.textColor = .label
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .left
        label.font = .systemFont(ofSize: 20, weight: .regular)
        label.text = "Title"
        label.numberOfLines = 0
        return label
    }()
    
    private let optionStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.spacing = 16
        stackView.distribution = .fillEqually
        return stackView
    }()
    
    
    private let nextButton: UIButton = {
            let button = UIButton(type: .system)
            button.translatesAutoresizingMaskIntoConstraints = false
            button.setTitle("Next Question", for: .normal)
            button.titleLabel?.font = .systemFont(ofSize: 18, weight: .semibold)
            button.backgroundColor = .systemBlue
            button.setTitleColor(.white, for: .normal)
            button.layer.cornerRadius = 12
            button.isHidden = true
            return button
        }()

    private var optionButtons: [UIButton] = []
    private var question: Question
    var onNextQuestion: (() -> Void)?
    var onScorePlus : (() -> Void)?
    
    init (question: Question) {
        self.question = question
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupUI()
        configQuestions()
         
    }
    
    
    private func setupUI() {
        view.backgroundColor = .systemBackground
                
                view.addSubview(questionLabel)
                view.addSubview(optionStackView)
                view.addSubview(nextButton)
                
                NSLayoutConstraint.activate([
                    questionLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 20),
                    questionLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
                    questionLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
                    
                    optionStackView.topAnchor.constraint(equalTo: questionLabel.bottomAnchor, constant: 40),
                    optionStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
                    optionStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
                    
                    nextButton.topAnchor.constraint(equalTo: optionStackView.bottomAnchor, constant: 40),
                    nextButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
                    nextButton.widthAnchor.constraint(equalToConstant: 200),
                    nextButton.heightAnchor.constraint(equalToConstant: 50),
                    nextButton.bottomAnchor.constraint(lessThanOrEqualTo: view.bottomAnchor, constant: -20)
                ])
                
                nextButton.addTarget(self, action: #selector(nextButtonTapped), for: .touchUpInside)
    }
    @objc private func nextButtonTapped() {
           onNextQuestion?()
       }

    private func configQuestions() {
         
               questionLabel.text = question.question
              
               // Create buttons for each option
               for (index, option) in question.options.enumerated() {
                   let button = createOptionButton(title: option, tag: index)
                   optionStackView.addArrangedSubview(button)
                   optionButtons.append(button)
               }
        
    }
    
    private func createOptionButton(title: String, tag: Int) -> UIButton {
            let button = UIButton(type: .system)
            button.setTitle(title, for: .normal)
            button.setTitleColor(.label, for: .normal)
            button.titleLabel?.font = .systemFont(ofSize: 16)
            button.contentHorizontalAlignment = .left
            button.backgroundColor = .systemGray6
            button.layer.cornerRadius = 10
            button.tag = tag
            button.heightAnchor.constraint(equalToConstant: 60).isActive = true
        
        button.titleLabel?.lineBreakMode = .byWordWrapping
        button.titleLabel?.numberOfLines = 0
        button.titleLabel?.textAlignment = .left
        button.contentEdgeInsets = UIEdgeInsets(top: 8, left: 12, bottom: 8, right: 12)
        
            button.addTarget(self, action: #selector(optionButtonTapped(_:)), for: .touchUpInside)
            return button
        }
    // MARK: - Actions
        @objc private func optionButtonTapped(_ sender: UIButton) {
            
            // Disable all buttons
            optionButtons.forEach { $0.isEnabled = false }
            
            let selectedOption = question.options[sender.tag]
            let isCorrect = selectedOption == question.answer
            
            if isCorrect {
                // Show green for correct answer
                sender.backgroundColor = .systemGreen
                sender.setTitleColor(.white, for: .normal)
                
                // Show next button
                nextButton.isHidden = false
                onScorePlus!()
                print("Score \(score)")
            } else {
                // Show red for incorrect answer
                sender.backgroundColor = .systemRed
                sender.setTitleColor(.white, for: .normal)
                
                // Highlight the correct answer
                if let correctIndex = question.options.firstIndex(of: question.answer),
                   correctIndex < optionButtons.count {
                    let correctButton = optionButtons[correctIndex]
                    correctButton.backgroundColor = .systemGreen
                    correctButton.setTitleColor(.white, for: .normal)
                }
                
                // Show next button
                nextButton.isHidden = false
            }
        }
     

}

#Preview{
    QuestionViewController(question: Question.moc)
}

