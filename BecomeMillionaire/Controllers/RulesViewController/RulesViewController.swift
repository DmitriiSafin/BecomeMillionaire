//
//  RulesViewController.swift
//  BecomeMillionaire
//
//  Created by Дмитрий on 28.03.2023.
//

import UIKit

class RulesViewController: UIViewController {
    
    private let backgroundView: UIImageView = {
        let background = UIImageView()
        background.image = UIImage(named: "Frame")
        //background.contentMode = .scaleToFill
        background.translatesAutoresizingMaskIntoConstraints = false
        return background
    }()
    
    private let rulesTextView: UITextView = {
        let textView = UITextView()
        textView.font = .systemFont(ofSize: 20)
        textView.textColor = .white
        textView.autocapitalizationType = .allCharacters
        textView.text = rulesText
        textView.textAlignment = .justified
        textView.backgroundColor = .clear
        textView.translatesAutoresizingMaskIntoConstraints = false
        return textView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
    }

    private func setupUI() {
        view.addSubview(backgroundView)
        view.addSubview(rulesTextView)
        
        NSLayoutConstraint.activate([
            backgroundView.topAnchor.constraint(equalTo: view.topAnchor),
            backgroundView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            backgroundView.leftAnchor.constraint(equalTo: view.leftAnchor),
            backgroundView.rightAnchor.constraint(equalTo: view.rightAnchor),
            
            rulesTextView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20),
            rulesTextView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -20),
            rulesTextView.topAnchor.constraint(equalTo: view.topAnchor, constant: 90),
            rulesTextView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -40)
        ])
    }
}
