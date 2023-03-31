//
//  CongratulationViewController.swift
//  BecomeMillionaire
//
//  Created by Дмитрий on 30.03.2023.
//

import UIKit

protocol CongratulationViewControllerDelegate: AnyObject {
    func restartFromCongratulation(dismiss: Void)
}

class CongratulationViewController: UIViewController {
    
    weak var delegate: CongratulationViewControllerDelegate?
    
    private let backgroundView: UIImageView = {
        let imageView = UIImageView(image: UIImage(named: "Frame"))
        imageView.contentMode = .scaleToFill
        return imageView
    }()
    
    private let congratulationLabel: UILabel = {
        let label = UILabel()
        label.text = "Поздравляю! Вы выйграли\n1 000 000 рублей!"
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 40)
        label.textColor = UIColor(red: 1, green: 215/255, blue: 0, alpha: 1)
        label.numberOfLines = 0
        return label
    }()
    
    private let milllionaireImage: UIImageView = {
        let imageView = UIImageView(image: UIImage(named: "millionaire"))
        return imageView
    }()
    
    private lazy var newGameButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Новая Игра", for: .normal)
        button.layer.cornerRadius = 15
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 30)
        button.backgroundColor = .green
        button.addTarget(self, action: #selector(newGameButtonPressed), for: .touchUpInside)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    @objc private func newGameButtonPressed() {
        delegate?.restartFromCongratulation(dismiss: dismiss(animated: false))
    }
    
    func changeAmount(_ amount: String) {
        congratulationLabel.text = "Поздравляю! Вы выйграли\n\(amount) рублей!"
    }
    
    private func setupUI() {
        let subviews = [backgroundView, congratulationLabel, milllionaireImage, newGameButton]
        subviews.forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
            view.addSubview($0)
        }
        
        NSLayoutConstraint.activate([
            backgroundView.topAnchor.constraint(equalTo: view.topAnchor),
            backgroundView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            backgroundView.leftAnchor.constraint(equalTo: view.leftAnchor),
            backgroundView.rightAnchor.constraint(equalTo: view.rightAnchor),
            
            milllionaireImage.topAnchor.constraint(equalTo: view.topAnchor, constant: 150),
            milllionaireImage.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            milllionaireImage.heightAnchor.constraint(equalToConstant: 200),
            milllionaireImage.widthAnchor.constraint(equalToConstant: 200),
            
            congratulationLabel.topAnchor.constraint(equalTo: milllionaireImage.bottomAnchor, constant: 50),
            congratulationLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            congratulationLabel.widthAnchor.constraint(equalToConstant: 250),
            
            newGameButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -100),
            newGameButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            newGameButton.heightAnchor.constraint(equalToConstant: 75),
            newGameButton.widthAnchor.constraint(equalToConstant: 250)
        ])
    }
}
