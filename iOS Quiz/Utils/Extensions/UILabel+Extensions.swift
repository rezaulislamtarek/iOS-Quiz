//
//  UILabel+Extensions.swift
//  iOS Quiz
//
//  Created by Rezaul Islam on 12/4/25.
//

import UIKit

extension UILabel {
    static func createLabel(
        alignment: NSTextAlignment = .center,
        fontSize : CGFloat = 16
    ) -> UILabel {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: fontSize, weight: .medium)
        label.numberOfLines = 0
        label.textAlignment = alignment
        return label
    }
}
