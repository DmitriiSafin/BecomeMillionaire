//
//  GameOverViewController.swift
//  BecomeMillionaire
//
//  Created by Дмитрий on 31.03.2023.
//

import UIKit

protocol GameOverViewControllerDelegate: AnyObject {
    func restartGame(isGameOver: Bool)
}

class GameOverViewController: UIViewController {
    
    weak var delegate: GameOverViewControllerDelegate?
    
    private let backgroundImage = UIImageView(image: UIImage(named: "backgroundImage"))
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.numberOfLines = 0
        label.textAlignment = .center
        return label
    }()
    
    private let logoImageview: UIImageView = {
        let imageView = UIImageView(image: UIImage(named: "millionaire"))
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    private lazy var restartButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Новая Игра", for: .normal)
        button.tintColor = .white
        button.addTarget(self, action: #selector(restartButtonPressed), for: .touchUpInside)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    @objc private func restartButtonPressed() {
        delegate?.restartGame(isGameOver: false)
        dismiss(animated: true)
    }
    
    private func setupUI() {
        
        titleLabel.text =
        """
        К сожалению,
        игра уже окончна.
        Попробуй еще раз!
        """
        
        UIView.animate(withDuration: 0.3, delay: 0.1, options: [.repeat, .autoreverse]) {
            self.logoImageview.alpha = 0.8
        }
        
        let subviews = [backgroundImage, titleLabel, restartButton, logoImageview]
        subviews.forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
            view.addSubview($0)
        }
        
        NSLayoutConstraint.activate([
            backgroundImage.topAnchor.constraint(equalTo: view.topAnchor),
            backgroundImage.leftAnchor.constraint(equalTo: view.leftAnchor),
            backgroundImage.rightAnchor.constraint(equalTo: view.rightAnchor),
            backgroundImage.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            restartButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            restartButton.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20),
            restartButton.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -20),
            restartButton.heightAnchor.constraint(equalToConstant: 100),
            
            titleLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            titleLabel.leftAnchor.constraint(equalTo: view.leftAnchor),
            titleLabel.rightAnchor.constraint(equalTo: view.rightAnchor),
            
            logoImageview.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            logoImageview.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 100),
            logoImageview.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -100)
        ])

    }
}
