//
//  QuizPlayerController+UI.swift
//  iOS Quiz
//
//  Created by Rezaul Islam on 12/4/25.
//

import UIKit

extension QuizPlayerController {
     
    func setupUI() {
        title = topic
        view.backgroundColor = .systemBackground
        
        view.addSubview(progressLabel)
        view.addSubview(timerLabel)
        view.addSubview(containerView)
        view.addSubview(activityIndicator)
        
        NSLayoutConstraint.activate([
            progressLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            progressLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            progressLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            
            timerLabel.topAnchor.constraint(equalTo: progressLabel.bottomAnchor, constant: 20),
            timerLabel.leadingAnchor.constraint(equalTo: progressLabel.leadingAnchor, constant: 20),
            timerLabel.trailingAnchor.constraint(equalTo: progressLabel.trailingAnchor, constant: -20),
            
            containerView.topAnchor.constraint(equalTo: timerLabel.bottomAnchor, constant: 20),
            containerView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            containerView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            containerView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20),
            
            activityIndicator.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            activityIndicator.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }

}
