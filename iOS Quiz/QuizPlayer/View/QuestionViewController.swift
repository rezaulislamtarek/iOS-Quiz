//
//  QuestionViewController.swift
//  iOS Quiz
//
//  Created by Rezaul Islam on 5/4/25.
//

import UIKit

class QuestionViewController: UIViewController {
    
    private let questionLabel: UILabel = {
        let label = UILabel()
        label.textColor = .label
        label.textAlignment = .justified
        label.font = .systemFont(ofSize: 20, weight: .regular)
        label.text = "Title"
        label.numberOfLines = 0
        return label
    }()
    
    private let optionStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 16
        stackView.distribution = .fillEqually
        return stackView
    }()

    
    private var question: Question
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
        self.view.addSubview(questionLabel)
        self.view.addSubview(optionStackView)
        questionLabel.translatesAutoresizingMaskIntoConstraints = false
        optionStackView.translatesAutoresizingMaskIntoConstraints = false
        
        
        NSLayoutConstraint.activate([
            questionLabel.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 70),
            questionLabel.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 20),
            questionLabel.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -20),
            
            optionStackView.topAnchor.constraint(equalTo: self.questionLabel.bottomAnchor, constant: 20),
            optionStackView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 20),
            optionStackView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -20),
            
//            <#T##UIView#>.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
//            <#T##UIView#>.centerYAnchor.constraint(equalTo: self.view.centerYAnchor),
//            <#UIView#>.widthAnchor.constraint(equalToConstant: 90),
//            <#UIView#>.heightAnchor.constraint(equalToConstant: 90),
        ])
    }

    private func configQuestions() {
        questionLabel.text = question.question
        
        for (index, option) in question.options.enumerated() {
            let optionBtn = createOptionButton(title: option, tag: option.count)
             optionStackView.addArrangedSubview(optionBtn)
        }
        
    }
    
    private func createOptionButton(title: String, tag: Int) -> UIButton {
            let button = UIButton(type: .system)
            button.setTitle(title, for: .normal)
            button.setTitleColor(.darkGray, for: .normal)
            button.titleLabel?.font = .systemFont(ofSize: 16)
            button.contentHorizontalAlignment = .center
            button.backgroundColor = .systemGray6
            button.layer.cornerRadius = 10
            button.tag = tag
            button.heightAnchor.constraint(equalToConstant: 60).isActive = true
            //button.addTarget(self, action: #selector(optionButtonTapped(_:)), for: .touchUpInside)
            return button
        }

     

}

#Preview{
    QuestionViewController(question: Question.moc)
}

