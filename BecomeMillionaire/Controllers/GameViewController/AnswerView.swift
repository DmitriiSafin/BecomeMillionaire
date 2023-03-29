//
//  AnswerView.swift
//  BecomeMillionaire
//
//  Created by Дмитрий on 29.03.2023.
//

import UIKit

protocol AnswerViewDelegate {
    func answerButtonTapped(with userAnswer: String, answerView: AnswerView)
}

class AnswerView: UIButton {
    
    private lazy var answerButton: UIButton = {
        let button = UIButton()
        button.contentHorizontalAlignment = .right
        button.tintColor = .white
        return button
    }()
    
    private lazy var optionAnswerLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.textColor = .white
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        dropShadow()
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func dropShadow() {
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOpacity = 0.5
        layer.shadowOffset = CGSize(width: 10, height: 10)
        layer.shadowRadius = 10
    }
    
    private func setupUI() {
        let subviews = [optionAnswerLabel, answerButton]
        subviews.forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
            addSubview($0)
        }
        
        NSLayoutConstraint.activate([
            optionAnswerLabel.topAnchor.constraint(equalTo: topAnchor),
            optionAnswerLabel.leftAnchor.constraint(equalTo: leftAnchor, constant: 20),
            optionAnswerLabel.bottomAnchor.constraint(equalTo: bottomAnchor),
            
            answerButton.topAnchor.constraint(equalTo: topAnchor),
            answerButton.leftAnchor.constraint(equalTo: leftAnchor),
            answerButton.rightAnchor.constraint(equalTo: rightAnchor, constant: -20),
            answerButton.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
    
}
