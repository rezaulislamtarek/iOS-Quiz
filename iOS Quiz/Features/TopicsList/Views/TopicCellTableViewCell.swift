//
//  TopicCellTableViewCell.swift
//  iOS Quiz
//
//  Created by Rezaul Islam on 12/4/25.
//

import UIKit

class TopicCellTableViewCell: UITableViewCell {

    static let identifier = "TopicCellTableViewCell"
    let iconImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        imageView.tintColor = .label
        return imageView
    }()
    
    let nameLabel: UILabel = .createLabel(alignment: .left, fontSize: 16)
    let cardView : UIView = .createCardView()
    
    // MARK: - initializer
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }
     
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - UI setup
    private func setupUI() {
        contentView.backgroundColor = .clear
        contentView.addSubview(cardView)
        cardView.addSubview(iconImageView)
        cardView.addSubview(nameLabel)
        
        NSLayoutConstraint.activate([
            
            cardView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 4),
            cardView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -4),
            cardView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 12),
            cardView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -12),
            
            iconImageView.topAnchor.constraint(equalTo: cardView.topAnchor, constant: 16),
            iconImageView.leadingAnchor.constraint(equalTo: cardView.leadingAnchor, constant: 16),
            iconImageView.heightAnchor.constraint(equalToConstant: 50),
            iconImageView.widthAnchor.constraint(equalToConstant: 50),
            
            nameLabel.topAnchor.constraint(equalTo: iconImageView.topAnchor),
            nameLabel.leadingAnchor.constraint(equalTo: iconImageView.trailingAnchor, constant: 16),
            nameLabel.bottomAnchor.constraint(equalTo: iconImageView.bottomAnchor),
        ])
    }

    func configure(with topic: Topic) {
        iconImageView.image = UIImage(systemName: topic.symbol)
        nameLabel.text = topic.name
    }


}
