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
    
    private var progressBar: UIProgressView = {
        let progress = UIProgressView()
        return progress
    }()
    
    private var answersStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.distribution = .fillEqually
        stackView.spacing = 10
        return stackView
    }()
    
    private var hintsStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.alignment = .leading
        stackView.distribution = .fillEqually
        stackView.spacing = 10
        return stackView
    }()
    
    private var isRightToMistake = false
    
    private var timer = Timer()
    private var gameOverTime: CFTimeInterval = 5
    private let gameManager = GameManager()
    private var currentQuestion: Question?
    private let questions = Question.getQuestions()
    private var questionView = QuestionView()
    private var hintView = EveryoneHelpHintView()
    
    private let backgroundImageView = UIImageView(image: UIImage(named: "backgroundImage"))
    
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
    
    private func showCustomView(with percents: [String: Int]) {
        hintView.configure(with: percents)
        hintView.showCustomAlert(for: view)
        view.addSubview(hintView)
    }
    
    private func configureAnswersStackView(with answers: [String], correct: String) {
        answers.forEach {
            let answerView = AnswerView()
            let optionLetter = gameManager.optionsLetters[answersStackView.arrangedSubviews.endIndex]
            answerView.configure(with: $0, answerOption: optionLetter)
            answerView.delegate = self
            answersStackView.addArrangedSubview(answerView)
        }
    }
    
    private func isRight(userAnswer: String, correctAnswer: String) -> Bool {
        timer.invalidate()
        
        if userAnswer == correctAnswer {
            gameManager.playSound(type: .win)
            DispatchQueue.main.asyncAfter(deadline: .now() + Constants.winTimeInterval) {
                
                self.answersStackView.isUserInteractionEnabled = true
            }
            gameManager.levelsCounter += 1
            return true
        } else {
            return false
        }
    }
    
    //private func showGameProcess(answerstatus: )
    
    private func setupUI() {
        let subviews = [
            backgroundImageView,
            questionView]
        
        subviews.forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
            view.addSubview($0)
        }
        
        NSLayoutConstraint.activate([
            backgroundImageView.topAnchor.constraint(equalTo: view.topAnchor),
            backgroundImageView.leftAnchor.constraint(equalTo: view.leftAnchor),
            backgroundImageView.rightAnchor.constraint(equalTo: view.rightAnchor),
            backgroundImageView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            questionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            questionView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20),
            questionView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -20),
            questionView.heightAnchor.constraint(equalToConstant: 150)
        ])
    }
    
}


extension GameViewController: AnswerViewDelegate {
    func answerButtonTapped(with userAnswer: String, answerView: AnswerView) {
        answerView.updateGradientChosenAnswer()
        gameManager.playSound(type: .chosenAnswer)
        answersStackView.isUserInteractionEnabled = false
        hintsStackView.isUserInteractionEnabled = false
        hintsStackView.alpha = 0.5
        
        Timer.scheduledTimer(withTimeInterval: Constants.chosenTime, repeats: false) {
            [ weak self ] _ in
            guard let correct = self?.currentQuestion?.correctAnswer else { return }
            //let isRight = self.isRight(
        }
    }
    
    
}
