//
//  UIActivityIndicatorView.swift
//  iOS Quiz
//
//  Created by Rezaul Islam on 12/4/25.
//
import UIKit

extension UIActivityIndicatorView {
    static func createLoadingIndicator() -> UIActivityIndicatorView {
        let activityIndicatorView = UIActivityIndicatorView(style: .large)
        activityIndicatorView.translatesAutoresizingMaskIntoConstraints = false
        activityIndicatorView.color = .label
        activityIndicatorView.hidesWhenStopped = true
        activityIndicatorView.startAnimating()
        return activityIndicatorView
    }
}
