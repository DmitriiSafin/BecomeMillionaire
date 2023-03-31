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
        case friendCall
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
                showGameProcess(answerStatus: .wrong)
                timer.invalidate()
            } else {
                cleanAnswers()
                cleanHints()
                configureHintsStackView()
                answersStackView.isUserInteractionEnabled = true
                hintView = EveryoneHelpHintView()
                gameManager.levelsCounter = 1
                currentQuestion = gameManager.getCurrentQuestion()
                setupUI()
                updateUI()
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateUI()
        configureHintsStackView()
        setupUI()
    }
    
    private func showCustomHint(with percents: [String: Int]) {
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
                self.showGameProcess(answerStatus: .right)
                self.answersStackView.isUserInteractionEnabled = true
            }
            gameManager.levelsCounter += 1
            return true
        } else {
            if isRightToMistake {
                isRightToMistake = false
                guard let answerViews = answersStackView.arrangedSubviews as? [AnswerView] else { return false }
                answerViews.forEach {
                    if $0.title == currentQuestion?.correctAnswer {
                        $0.updateGradient(with: true)
                    }
                }
                gameManager.playSound(type: .win)
                DispatchQueue.main.asyncAfter(wallDeadline: .now() + Constants.winTimeInterval) {
                    self.showGameProcess(answerStatus: .right)
                }
                gameManager.levelsCounter += 1
                return false
            }
            gameManager.playSound(type: .lose)
            delayGameOver()
            return false
        }
    }
    
    private func showGameProcess(answerStatus: AnswerStatus) {
        guard let currentQuestion = currentQuestion else { return }
        let level = currentQuestion.level
        let gameProgressVC = GameProgressViewController(currentQuestion: level, answerStatus: answerStatus)
        gameProgressVC.delegate = self
        gameProgressVC.modalPresentationStyle = .fullScreen
        present(gameProgressVC, animated: true)
    }
    
    private func updateUI() {
        currentQuestion = gameManager.getCurrentQuestion()
        gameOverTime = 30
        hintsStackView.alpha = 1
        hintsStackView.isUserInteractionEnabled = true
        
        guard let currentQuestion = currentQuestion else {
            timer.invalidate()
            showGameProcess(answerStatus: .right)
            gameManager.playSound(type: .winGame)
            return
        }
        
        questionView.configure(with: currentQuestion.ask,
                               questionNumber: currentQuestion.level,
                               price: currentQuestion.getPrice(with: currentQuestion.level))
        
        configureAnswersStackView(with: currentQuestion.getAllAnswers(),
                                  correct: currentQuestion.correctAnswer)
        
        gameManager.playSound(type: .timerForResponse)
        timerForResponse()
    }
    
    private func cleanAnswers() {
        answersStackView.arrangedSubviews.forEach {
            answersStackView.removeArrangedSubview($0)
            $0.removeFromSuperview()
        }
    }
    
    private func cleanHints() {
        hintsStackView.arrangedSubviews.forEach {
            hintsStackView.removeArrangedSubview($0)
            $0.removeFromSuperview()
        }
    }
    
    @objc private func hintPressed(_ sender: UIButton) {
        
        switch sender.currentTitle {
        case "fiftyOnFifty":
            !sender.isSelected ? fiftyOnFifty() : print("Hint used already")
        case "friendCall":
            !sender.isSelected ? friendCall() : print("Hint used already")
        case "everyoneHelp":
            !sender.isSelected ? everyoneHelp() : print("Hint used already")
        case "makeMistake":
            !sender.isSelected ? rightToMistake() : print("Hint used already")
        default:
            break
        }
        sender.isSelected.toggle()
        sender.isUserInteractionEnabled = false
    }
    
    private func configureHintsStackView() {
        HintType.allCases.forEach {
            let button = UIButton(type: .system)
            button.setImage(UIImage(named: $0.rawValue)?.withRenderingMode(.alwaysOriginal), for: .normal)
            button.setTitle($0.rawValue, for: .normal)
            button.titleLabel?.isHidden = true
            button.imageView?.contentMode = .scaleAspectFit
            button.tintColor = .clear
            button.addTarget(self, action: #selector(hintPressed), for: .touchUpInside)
            switch $0 {
            case .fiftyOnFifty:
                button.setImage(UIImage(named: "forbiddenFiftyOnFifty")?.withRenderingMode(.alwaysOriginal),
                                    for: .selected)
            case .friendCall:
                button.setImage(UIImage(named: "forbiddenFriendCall")?.withRenderingMode(.alwaysOriginal),
                                    for: .selected)
            case .everyoneHelp:
                button.setImage(UIImage(named: "forbiddenEveryoneHelp")?.withRenderingMode(.alwaysOriginal),
                                    for: .selected)
            case .makeMistake:
                button.setImage(UIImage(named: "forbiddenMakeMistake")?.withRenderingMode(.alwaysOriginal),
                                    for: .selected)
            }
            hintsStackView.addArrangedSubview(button)
        }
    }
    
    private func delayGameOver() {
        guard let answersViews = answersStackView.arrangedSubviews as? [AnswerView] else { return }
        answersViews.forEach {
            if $0.title == currentQuestion?.correctAnswer {
                $0.updateGradient(with: true)
            }
        }
        Timer.scheduledTimer(withTimeInterval: Constants.gameOverRightAnswerTime, repeats: false) { _ in
            self.isGameOver = true
        }
    }
    
    private func timerForResponse() {
        progressBar.progress = 0
        
        timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true, block: { [ weak self ] _ in
            guard let self = self else { return }
            if self.gameOverTime > 0 {
                self.gameOverTime -= 1
                self.progressBar.progress = 1 - Float(self.gameOverTime)/30
            } else {
                self.timer.invalidate()
                self.gameManager.playSound(type: .lose)
                self.delayGameOver()
            }
        })
    }
    
    private func rightToMistake() {
        isRightToMistake = true
    }
    
    private func everyoneHelp() {
        guard let currentQuestion = currentQuestion,
        let answersViews = answersStackView.arrangedSubviews as? [AnswerView] else { return }
        
        var index = 0
        var result = [String: Int]()
        
        for answersView in answersViews {
            if answersView.title == currentQuestion.correctAnswer {
                result[gameManager.optionsLetters[index]] = Int.random(in: 70...100)
            } else {
                result[gameManager.optionsLetters[index]] = Int.random(in: 0...69)
            }
            index += 1
        }
        showCustomHint(with: result)
    }
    
    private func friendCall() {
        guard let currentQuestion = currentQuestion else { return }
        if Int.random(in: 1...10) <= 8 {
            let alert = UIAlertController(title: "Call a friend", message: currentQuestion.correctAnswer, preferredStyle: .alert)
            let action = UIAlertAction(title: "OK", style: .default, handler: nil)
            alert.addAction(action)
            present(alert, animated: true)
        } else {
            let alert = UIAlertController(title: "Call a friend", message: currentQuestion.wrongAnswers[Int.random(in: 0...currentQuestion.wrongAnswers.count - 1)], preferredStyle: .alert)
            let action = UIAlertAction(title: "OK", style: .default, handler: nil)
            alert.addAction(action)
            present(alert, animated: true)
        }
    }
    
    private func fiftyOnFifty() {
        guard let currentQuestion = currentQuestion else { return }
        var buff : [AnswerView] = []
        answersStackView.arrangedSubviews.forEach {
            let a = $0 as! AnswerView
            if a.title != currentQuestion.correctAnswer {
                buff.append(a)
            }
        }
        buff.shuffle()
        buff.remove(at: 0).fiftyOnFiftySetup()
        buff.remove(at: 0).fiftyOnFiftySetup()
        self.currentQuestion?.wrongAnswers = [buff[0].title]
    }
    
    private func setupUI() {
        let subviews = [backgroundImageView,
                        questionView,
                        answersStackView,
                        hintsStackView,
                        progressBar
        ]
        
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
            questionView.heightAnchor.constraint(equalToConstant: 150),
            
            answersStackView.topAnchor.constraint(equalTo: questionView.bottomAnchor),
            answersStackView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20),
            answersStackView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -20),
            answersStackView.heightAnchor.constraint(equalToConstant: 400),
            
            hintsStackView.topAnchor.constraint(equalTo: answersStackView.bottomAnchor),
            hintsStackView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20),
            hintsStackView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -20),
            hintsStackView.bottomAnchor.constraint(equalTo: progressBar.bottomAnchor),
            
            progressBar.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20),
            progressBar.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -20),
            progressBar.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
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
            guard let self = self, let correct = self.currentQuestion?.correctAnswer else { return }
            let isRight = self.isRight(userAnswer: userAnswer, correctAnswer: correct)
            answerView.updateGradient(with: isRight)
        }
    }
}

extension GameViewController: GameOverViewControllerDelegate {
    func restartGame(isGameOver: Bool) {
        self.isGameOver = isGameOver
    }
}

extension GameViewController: GameProgressViewControllerDelegate {
    func restartGame() {
        isGameOver = false
    }
    
    func continueGame() {
        cleanAnswers()
        updateUI()
        answersStackView.isUserInteractionEnabled = true
    }
    
    
}
