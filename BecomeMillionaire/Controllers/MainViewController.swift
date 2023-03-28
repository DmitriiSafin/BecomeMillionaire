//
//  MainViewController.swift
//  BecomeMillionaire
//
//  Created by Дмитрий on 28.03.2023.
//

import UIKit

class MainViewController: UIViewController {
    
    let backgroundView: UIImageView = {
        let background = UIImageView()
        background.image = UIImage(named: "Frame")
        background.translatesAutoresizingMaskIntoConstraints = false
        return background
    }()
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "The Game"
        label.textColor = .yellow
        // проверить шрифт
        label.font = UIFont(name: "Avenir Next Bold", size: 30)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let logoImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "Logomainview")
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    let welcomeLabel: UILabel = {
        let label = UILabel()
        label.text = "welcome"
        label.textColor = .white
        label.font = UIFont(name: "Avenir Next", size: 30)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let nameLabel: UILabel = {
        let label = UILabel()
        label.text = "to Who Wants to be a Millionare"
        label.textColor = .white
        label.font = UIFont(name: "Avenir Next Bold", size: 40)
        label.adjustsFontSizeToFitWidth = true
        label.textAlignment = .center
        label.numberOfLines = 2
        label.minimumScaleFactor = 0.5
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var rulesButton: UIButton = {
        let button = UIButton()
        button.setTitle("Rules of the game", for: .normal)
        // подобрать цвет
        button.tintColor = .cyan
        button.titleLabel?.font = UIFont(name: "Avenir Next Bold", size: 35)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(rulesTapButton), for: .touchUpInside)
        return button
    }()
    
    lazy var startButton: UIButton = {
        let button = UIButton()
        button.setTitle("Start", for: .normal)
        // подобрать цвет
        button.tintColor = .yellow
        button.backgroundColor = .green
        button.layer.cornerRadius = 10
        button.titleLabel?.font = UIFont(name: "Avenir Next Bold", size: 50)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(startGameTapButton), for: .touchUpInside)
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
        setupConstraints()
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
    
    private func setupView() {
        view.addSubview(backgroundView)
        view.addSubview(titleLabel)
        view.addSubview(logoImageView)
        view.addSubview(welcomeLabel)
        view.addSubview(nameLabel)
        view.addSubview(rulesButton)
        view.addSubview(startButton)
    }
    
    private func setupConstraints() {
        
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

