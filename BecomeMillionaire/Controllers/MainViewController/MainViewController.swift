//
//  MainViewController.swift
//  BecomeMillionaire
//
//  Created by Дмитрий on 28.03.2023.
//

import UIKit

class MainViewController: UIViewController {
    
    private let backgroundView: UIImageView = {
        let background = UIImageView()
        background.image = UIImage(named: "Frame")
        return background
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "The Game"
        label.textColor = .yellow
        label.font = UIFont(name: "Avenir Next Bold", size: 30)
        return label
    }()
    
    private let logoImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "Logomainview")
        return imageView
    }()
    
    private let welcomeLabel: UILabel = {
        let label = UILabel()
        label.text = "welcome"
        label.textColor = .white
        label.font = UIFont(name: "Avenir Next", size: 30)
        return label
    }()
    
    private let nameLabel: UILabel = {
        let label = UILabel()
        label.text = "to Who Wants to be a Millionare"
        label.textColor = .white
        label.font = UIFont(name: "Avenir Next Bold", size: 40)
        label.adjustsFontSizeToFitWidth = true
        label.textAlignment = .center
        label.numberOfLines = 2
        label.minimumScaleFactor = 0.5
        return label
    }()
    
    private lazy var rulesButton: UIButton = {
        let button = UIButton()
        button.setTitle("Rules of the game", for: .normal)
        button.tintColor = .cyan
        button.titleLabel?.font = UIFont(name: "Avenir Next Bold", size: 35)
        button.addTarget(self, action: #selector(rulesTapButton), for: .touchUpInside)
        return button
    }()
    
    private lazy var startButton: UIButton = {
        let button = UIButton()
        button.setTitle("Start", for: .normal)
        button.tintColor = .yellow
        button.backgroundColor = .green
        button.layer.cornerRadius = 10
        button.titleLabel?.font = UIFont(name: "Avenir Next Bold", size: 50)
        button.addTarget(self, action: #selector(startGameTapButton), for: .touchUpInside)
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }

    @objc private func rulesTapButton() {
        let rootVC = RulesViewController()
        rootVC.navigationItem.leftBarButtonItem = UIBarButtonItem(title: "< Back", style: .done, target: self, action: #selector(dismissSelf))
        
        rootVC.navigationItem.leftBarButtonItem?.setTitleTextAttributes([.foregroundColor: UIColor.yellow, .font: UIFont.systemFont(ofSize: 25)], for: .normal)
        
        let navVC = UINavigationController(rootViewController: rootVC)
        navVC.modalPresentationStyle = .fullScreen
        present(navVC, animated: true)
    }
    
    @objc private func dismissSelf() {
        dismiss(animated: true)
    }
    
    @objc private func startGameTapButton() {
        let rootVC = GameViewController()
        let navVC = UINavigationController(rootViewController: rootVC)
        navVC.modalPresentationStyle = .fullScreen
        present(navVC, animated: true)
    }
    
    private func setupUI() {
        let subviews = [backgroundView,
                        titleLabel,
                        logoImageView,
                        welcomeLabel,
                        nameLabel,
                        rulesButton,
                        startButton]
        subviews.forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
            view.addSubview($0)
        }
        
        NSLayoutConstraint.activate([
            backgroundView.topAnchor.constraint(equalTo: view.topAnchor),
            backgroundView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            backgroundView.leftAnchor.constraint(equalTo: view.leftAnchor),
            backgroundView.rightAnchor.constraint(equalTo: view.rightAnchor),
            
            titleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10),
            titleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            logoImageView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 10),
            logoImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            logoImageView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.5),
            logoImageView.heightAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.5),
            
            welcomeLabel.topAnchor.constraint(equalTo: logoImageView.bottomAnchor, constant: 10),
            welcomeLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            nameLabel.topAnchor.constraint(equalTo: welcomeLabel.bottomAnchor, constant: 10),
            nameLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            nameLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            
            rulesButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20),
            rulesButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            rulesButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            rulesButton.heightAnchor.constraint(equalToConstant: 60),
            
            startButton.bottomAnchor.constraint(equalTo: rulesButton.topAnchor, constant: -20),
            startButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 60),
            startButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -60),
            startButton.heightAnchor.constraint(equalToConstant: 60),
        ])
    }
}

