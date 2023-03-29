//
//  GameViewController.swift
//  BecomeMillionaire
//
//  Created by Дмитрий on 28.03.2023.
//

import UIKit

protocol GameViewControllerDelegate {
    func updateGradient(with isRight: Bool)
    func updateGradientChosenAnswer()
}

class GameViewController: UIViewController {
    
    private enum HintType: String, CaseIterable {
        case fiftyOnFifty
        case FriendCall
        case everyoneHelp
        case makeMistake
    }
    
    private enum Constants {
        static let winTimeInterval: TimeInterval = 3.5
        static let chosenTime: TimeInterval = 2
        static let gameOverRightAnswerTime: TimeInterval = 4
    }
    
    private var isRightToMistake = false
    private let questions = Question.getQuestions()
    private var timer = Timer()
    private var gameOverTime: CFTimeInterval = 5
    private let gameManager = GameManager()
    private var currentQuestion: Question?
    
    private var questionView = QuestionView()
    
    private var isGameOver: Bool = false {
        didSet {
            if isGameOver {
                
            } else {
                
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    //private func showGameProcess(answerstatus: )
    
    private func setupUI() {
        let subviews = [questionView]
        
        subviews.forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
            view.addSubview($0)
        }
        
        NSLayoutConstraint.activate([
            questionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            questionView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20),
            questionView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -20),
            questionView.heightAnchor.constraint(equalToConstant: 150)
        ])
    }
    
}
