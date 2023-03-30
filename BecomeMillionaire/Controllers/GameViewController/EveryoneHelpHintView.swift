//
//  EveryoneHelpHintView.swift
//  BecomeMillionaire
//
//  Created by Дмитрий on 30.03.2023.
//

import UIKit

class EveryoneHelpHintView: UIView {
    
    private var backgroundView: UIView = {
        let view = UIView()
        view.alpha = 0
        view.bounds = UIScreen.main.nativeBounds
        view.backgroundColor = .black
        return view
    }()
    
    private let progressBarsStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.distribution = .equalSpacing
        stackView.spacing = 20
        return stackView
    }()
    
    private lazy var dismissButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Ok", for: .normal)
        button.tintColor = .white
        button.addTarget(self, action: #selector(dismissButtonTapped), for: .touchUpInside)
        return button
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
    
    
    private var percents = [String: Int]()
    
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
    }
    
    func configure(with percents: [String: Int]) {
        self.percents = percents
    }
    
    private func configureStackView() {
        
        let letters = percents.keys.sorted()
        
        for letter in letters {
            
            if let percent = percents[letter] {
                
                let lettersLabel: UILabel = {
                    let label = UILabel()
                    label.text = letter
                    label.adjustsFontSizeToFitWidth = true
                    label.textColor = .white
                    return label
                }()
                
                let percentLabel: UILabel = {
                    let label = UILabel()
                    label.text = String(percent)
                    label.adjustsFontSizeToFitWidth = true
                    label.textColor = .white
                    return label
                }()
            }
        }
    }
    
    @objc private func dismissButtonTapped() {
        UIView.animate(withDuration: 0.3) { [ weak self ] in
            self?.alpha = 0
            self?.backgroundView.alpha = 0
        } completion: { _ in
            self.removeFromSuperview()
        }
    }
    
    private func dropShadow() {
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOpacity = 0.5
        layer.shadowOffset = CGSize(width: 10, height: 10)
        layer.shadowRadius = 10
    }
    
    private func setupUI() {
        layer.cornerRadius = 10
    }
}
