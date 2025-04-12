//
//  UIView+Extensions.swift
//  iOS Quiz
//
//  Created by Rezaul Islam on 12/4/25.
//

import Foundation
import UIKit

extension UIView {
    static func createContaineView() -> UIView {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .systemBackground
        view.layer.cornerRadius = 16
        view.layer.shadowColor = UIColor.black.cgColor
        view.layer.shadowOpacity = 0.25
        view.layer.shadowOffset = CGSize(width: 0, height: 5)
        view.layer.shadowRadius = 10
        return view
    }
    
    static func createCardView() -> UIView {
        let cardView = UIView()
        cardView.translatesAutoresizingMaskIntoConstraints = false
        cardView.backgroundColor = .systemGreen.withAlphaComponent(0.15)
        cardView.layer.cornerRadius = 16
        cardView.layer.shadowColor = UIColor.black.cgColor
        cardView.layer.shadowOpacity = 0.25
        cardView.layer.shadowOffset = CGSize(width: 0, height: 2)
        cardView.layer.shadowRadius = 8
        
        return cardView
    }
    
}
