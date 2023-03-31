//
//  QuestionView.swift
//  BecomeMillionaire
//
//  Created by Дмитрий on 29.03.2023.
//

import UIKit

class QuestionView: UIView {
    
    private let logoImageView: UIImageView = {
        let imageView = UIImageView(image: UIImage(named: "logo"))
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    private let questionLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.textColor = .white
        label.adjustsFontSizeToFitWidth = true
        return label
    }()
    
    private let numberQuestionLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        return label
    }()
    
    private let priceQuestionLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        return label
    }()
    
    private lazy var bottomStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [numberQuestionLabel, priceQuestionLabel])
        stackView.distribution = .equalSpacing
        return stackView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(with question: String, questionNumber: Int, price: Int) {
        questionLabel.text = question
        numberQuestionLabel.text = "Вопрос \(questionNumber)"
        priceQuestionLabel.text = "\(price) руб"
    }
    
    private func setupUI() {
        let subviews = [logoImageView, questionLabel, bottomStackView]
        subviews.forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
            addSubview($0)
        }
        
        NSLayoutConstraint.activate([
            logoImageView.topAnchor.constraint(equalTo: topAnchor),
            logoImageView.leftAnchor.constraint(equalTo: leftAnchor),
            logoImageView.widthAnchor.constraint(equalToConstant: 100),
            logoImageView.heightAnchor.constraint(equalToConstant: 100),
            logoImageView.bottomAnchor.constraint(equalTo: bottomStackView.topAnchor),
            
            questionLabel.topAnchor.constraint(equalTo: topAnchor),
            questionLabel.leftAnchor.constraint(equalTo: logoImageView.rightAnchor, constant: 20),
            questionLabel.rightAnchor.constraint(equalTo: rightAnchor),
            questionLabel.bottomAnchor.constraint(equalTo: logoImageView.bottomAnchor),
            
            bottomStackView.topAnchor.constraint(equalTo: questionLabel.bottomAnchor),
            bottomStackView.leftAnchor.constraint(equalTo: leftAnchor),
            bottomStackView.rightAnchor.constraint(equalTo: rightAnchor),
            bottomStackView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
}
