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
        let colors: [UIColor] = [#colorLiteral(red: 0.2530327737, green: 0.4159591794, blue: 0.5364745855, alpha: 1), #colorLiteral(red: 0.1300314665, green: 0.2300171852, blue: 0.3798839748, alpha: 1), #colorLiteral(red: 0.2530327737, green: 0.4159591794, blue: 0.5364745855, alpha: 1)]
        gradientLayer.colors = colors.map { $0.cgColor }
        gradientLayer.startPoint = CGPoint(x: 0, y: 1)
        gradientLayer.endPoint = CGPoint(x: 0, y: 0)
        gradientLayer.cornerRadius = 10
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
            gradientLayer.colors = [#colorLiteral(red: 0.4666666687, green: 0.7647058964, blue: 0.2666666806, alpha: 1), #colorLiteral(red: 0.2745098174, green: 0.4862745106, blue: 0.1411764771, alpha: 1), #colorLiteral(red: 0.4666666687, green: 0.7647058964, blue: 0.2666666806, alpha: 1)].map { $0.cgColor }
        } else {
            gradientLayer.colors = [#colorLiteral(red: 0.9372549057, green: 0.3490196168, blue: 0.1921568662, alpha: 1), #colorLiteral(red: 0.7450980544, green: 0.1568627506, blue: 0.07450980693, alpha: 1), #colorLiteral(red: 0.9372549057, green: 0.3490196168, blue: 0.1921568662, alpha: 1)].map { $0.cgColor }
        }
    }
    
    func updateGradientChosenAnswer() {
        gradientLayer.colors = [#colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1), #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1), #colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1)].map { $0.cgColor }
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
            answerButton.leftAnchor.constraint(equalTo: leftAnchor, constant: 40),
            answerButton.rightAnchor.constraint(equalTo: rightAnchor, constant: -20),
            answerButton.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
    
}
