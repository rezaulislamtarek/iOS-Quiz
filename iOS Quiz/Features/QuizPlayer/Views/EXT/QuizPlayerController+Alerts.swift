//
//  QuizPlayerController+Alerts.swift
//  iOS Quiz
//
//  Created by Rezaul Islam on 12/4/25.
//

import UIKit

extension QuizPlayerController {
    func createCustomAlert(
        title : String,
        message :String,
        tryAgainAction : @escaping () -> Void,
        exitAction : @escaping () -> Void
    ) -> UIAlertController{
        let aleartController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        aleartController.addAction(UIAlertAction(title: "Try again", style: .default){ _ in tryAgainAction() })
        aleartController.addAction(UIAlertAction(title: "Exit Quiz", style: .destructive){ _ in exitAction() })
        
        return aleartController
    }
    
    
    func showQuizEndedAlert(score: Int, outOf: Int) {
    
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
