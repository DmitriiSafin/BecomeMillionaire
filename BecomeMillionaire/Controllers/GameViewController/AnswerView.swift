//
//  AnswerView.swift
//  BecomeMillionaire
//
//  Created by Дмитрий on 29.03.2023.
//

import UIKit

protocol AnswerViewDelegate: AnyObject {
    func answerButtonTapped(with userAnswer: String, answerView: AnswerView)
}

class AnswerView: UIButton {
    
    weak var delegate: AnswerViewDelegate?
    
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
    
    lazy var gradientLayer: CAGradientLayer = {
        let gradientLayer = CAGradientLayer()
        gradientLayer.borderColor = UIColor.gray.cgColor
        gradientLayer.borderWidth = 1
        let colors: [UIColor] = [.gray, .black, .gray]
        gradientLayer.colors = colors.map { $0.cgColor }
        gradientLayer.startPoint = CGPoint(x: 0, y: 1)
        gradientLayer.endPoint = CGPoint(x: 0, y: 0)
        layer.insertSublayer(gradientLayer, at: 0)
        return gradientLayer
    }()
    
    var option = String()
    var title = String()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        dropShadow()
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        gradientLayer.frame = bounds
        optionAnswerLabel.text = option
        answerButton.setTitle(title, for: .normal)
    }
    
    @objc private func answerButtonTapped(_ sender: UIButton) {
        delegate?.answerButtonTapped(with: title, answerView: self)
    }
    
    func updateGradient(with isRight: Bool) {
        if isRight {
            gradientLayer.colors = [UIColor.green.cgColor]
        } else {
            gradientLayer.colors = [UIColor.red.cgColor]
        }
    }
    
    func updateGradientChosenAnswer() {
        gradientLayer.colors = [UIColor.gray.cgColor]
    }
    
    func configure(with bodyAnswer: String, answerOption: String) {
        option = answerOption
        title = bodyAnswer
        answerButton.addTarget(self, action: #selector(answerButtonTapped), for: .touchUpInside)
    }
    
    func fiftyOnFiftySetup() {
        self.alpha = 0.5
        answerButton.isEnabled = false
    }
    
    private func dropShadow() {
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOpacity = 0.5
        layer.shadowOffset = CGSize(width: 10, height: 10)
        layer.shadowRadius = 10
    }
    
    private func setupUI() {
        layer.cornerRadius = 10
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
