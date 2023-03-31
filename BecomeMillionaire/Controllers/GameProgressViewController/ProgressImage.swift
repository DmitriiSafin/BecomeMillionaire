//
//  ProgressImage.swift
//  BecomeMillionaire
//
//  Created by Дмитрий on 30.03.2023.
//

import UIKit

enum ColorImage: String {
    case red = "red"
    case green = "green"
    case blue = "blue"
    case purple = "purple"
    case gold = "gold"
}

class ProgressImage: UIView {
    
    private let questionNumber: UILabel = {
        let label = UILabel()
        label.textColor = .white
        return label
    }()
    
    private let winningSum: UILabel = {
        let label = UILabel()
        label.textColor = .white
        return label
    }()
    
    private let contentImage: UIImageView = {
        let image = UIImageView()
        return image
    }()
    
    init(questionNumber: String, winningSum: String, colorImage: ColorImage) {
        self.questionNumber.text = questionNumber
        self.winningSum.text = winningSum
        self.contentImage.image = UIImage(named: colorImage.rawValue)
        super.init(frame: .zero)
        self.setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        let subviews = [contentImage, questionNumber, winningSum]
        subviews.forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
            addSubview($0)
        }
        
        NSLayoutConstraint.activate([
            contentImage.topAnchor.constraint(equalTo: topAnchor),
            contentImage.leftAnchor.constraint(equalTo: leftAnchor),
            contentImage.rightAnchor.constraint(equalTo: rightAnchor),
            contentImage.bottomAnchor.constraint(equalTo: bottomAnchor),
            
            questionNumber.leftAnchor.constraint(equalTo: leftAnchor, constant: 15),
            questionNumber.centerYAnchor.constraint(equalTo: centerYAnchor),
            
            winningSum.rightAnchor.constraint(equalTo: rightAnchor, constant: -15),
            winningSum.centerYAnchor.constraint(equalTo: centerYAnchor)
        ])
    }
}
