//
//  GameProgressViewController.swift
//  BecomeMillionaire
//
//  Created by Дмитрий on 30.03.2023.
//

import UIKit

struct PrizeTable {
    var qwestionNumber: Int
    var winningSum: Int
    var color: ColorImage
    
    static func getPrizeTable() -> [PrizeTable] {
        [PrizeTable(qwestionNumber: 15, winningSum: 1000000, color: .gold),
         PrizeTable(qwestionNumber: 14, winningSum: 500000, color: .purple),
         PrizeTable(qwestionNumber: 13, winningSum: 250000, color: .purple),
         PrizeTable(qwestionNumber: 12, winningSum: 125000, color: .purple),
         PrizeTable(qwestionNumber: 11, winningSum: 64000, color: .purple),
         PrizeTable(qwestionNumber: 10, winningSum: 32000, color: .blue),
         PrizeTable(qwestionNumber: 9, winningSum: 16000, color: .purple),
         PrizeTable(qwestionNumber: 8, winningSum: 8000, color: .purple),
         PrizeTable(qwestionNumber: 7, winningSum: 4000, color: .purple),
         PrizeTable(qwestionNumber: 6, winningSum: 2000, color: .purple),
         PrizeTable(qwestionNumber: 5, winningSum: 1000, color: .blue),
         PrizeTable(qwestionNumber: 4, winningSum: 500, color: .purple),
         PrizeTable(qwestionNumber: 3, winningSum: 300, color: .purple),
         PrizeTable(qwestionNumber: 2, winningSum: 200, color: .purple),
         PrizeTable(qwestionNumber: 1, winningSum: 100, color: .green)
        ]
    }
}

enum AnswerStatus {
    case right
    case wrong
}

protocol GameProgressViewControllerDelegate: AnyObject {
    func restartGame()
    func continueGame()
}

class GameProgressViewController: UIViewController {
    
    weak var delegate: GameProgressViewControllerDelegate?
    
    var currentQuestion = 1
    var winningAmount = 0
    
    var answerStatus: AnswerStatus = .right
    
    private var prizeTable = PrizeTable.getPrizeTable()
    
    private let millianaireImage: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "millionaire")
        return imageView
    }()
    
    private let messageLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = .boldSystemFont(ofSize: 22)
        label.textAlignment = .center
        label.numberOfLines = 0
        return label
    }()
    
    private lazy var nextQuestionButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Cледующий вопрос", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 18)
        button.layer.cornerRadius = 15
        button.backgroundColor = .blue
        button.addTarget(self, action: #selector(nextQuestionButtonPressed), for: .touchUpInside)
        return button
    }()
    
    private lazy var newGameButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Новая игра", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 25)
        button.layer.cornerRadius = 15
        button.backgroundColor = .blue
        button.addTarget(self, action: #selector(newGameButtonPressed), for: .touchUpInside)
        return button
    }()
    
    private lazy var takeMoneyButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Забрать деньги", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 18)
        button.layer.cornerRadius = 15
        button.backgroundColor = .red
        button.addTarget(self, action: #selector(takeMoneyButtonPressed), for: .touchUpInside)
        return button
    }()
    
    private let progressImageStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 5
        stackView.distribution = .fillEqually
        return stackView
    }()
    
    init(currentQuestion: Int = 1, answerStatus: AnswerStatus = .right) {
        self.currentQuestion = currentQuestion
        self.answerStatus = answerStatus
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let backgroundImage = UIImageView(frame: UIScreen.main.bounds)
        backgroundImage.image = UIImage(named: "backgroundImage")
        backgroundImage.contentMode = .scaleAspectFill
        view.insertSubview(backgroundImage, at: 0)
        
        setupUI()
        getStackView()
        endAmount()
    }
    
    private func endAmount() {
        winningAmount = getWinningAmount(currentQuestion: currentQuestion)
        
        if answerStatus == .right {
            messageLabel.text =
            """
            Твой выйгрыш \(winningAmount) рублей!
            """
        } else {
            messageLabel.text =
            """
            ИГРА ОКОНЧЕНА!
            Твой выйгрыш \(winningAmount) рублей!
            """
        }
    }
    
    @objc private func nextQuestionButtonPressed() {
        delegate?.continueGame()
        dismiss(animated: true)
    }
    
    @objc private func newGameButtonPressed() {
        delegate?.restartGame()
        dismiss(animated: true)
    }
    
    @objc private func takeMoneyButtonPressed() {
        let congratulationVC = CongratulationViewController()
        congratulationVC.delegate = self
        congratulationVC.changeAmount("\(winningAmount)")
        congratulationVC.modalPresentationStyle = .fullScreen
        present(congratulationVC, animated: true)
    }
    
    private func getWinningAmount(currentQuestion: Int) -> Int {
        switch answerStatus {
        case .right:
            return prizeTable[15 - currentQuestion].winningSum
        case .wrong:
            switch currentQuestion {
            case ..<5: return 0
            case 5..<10: return 1000
            case 10...15: return 32000
            default: return 1000000
            }
        }
    }
    
    private func getStackView() {
        for prize in prizeTable {
            if prize.qwestionNumber < currentQuestion {
                let questionImage = ProgressImage(questionNumber: "Вопрос \(prize.qwestionNumber)", winningSum: "\(prize.winningSum) руб", colorImage: .green)
                progressImageStackView.addArrangedSubview(questionImage)
            } else if prize.qwestionNumber == currentQuestion {
                switch answerStatus {
                case .right:
                    let questionImage = ProgressImage(questionNumber: "Вопрос \(prize.qwestionNumber)", winningSum: "\(prize.winningSum) руб", colorImage: .green)
                    progressImageStackView.addArrangedSubview(questionImage)
                case .wrong:
                    let questionImage = ProgressImage(questionNumber: "Вопрос \(prize.qwestionNumber)", winningSum: "\(prize.winningSum) руб", colorImage: .red)
                    progressImageStackView.addArrangedSubview(questionImage)
                }
            } else {
                let questionImage = ProgressImage(questionNumber: "Вопрос \(prize.qwestionNumber)", winningSum: "\(prize.winningSum) руб", colorImage: prize.color)
                progressImageStackView.addArrangedSubview(questionImage)
            }
        }
    }
}

extension GameProgressViewController {
    
    private func setupUI() {
        let subviews = [millianaireImage, progressImageStackView, messageLabel, takeMoneyButton, nextQuestionButton, newGameButton]
        subviews.forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
        
        view.addSubview(millianaireImage)
        view.addSubview(progressImageStackView)
        view.addSubview(messageLabel)
        
        switch answerStatus {
        case .right:
            view.addSubview(nextQuestionButton)
            view.addSubview(takeMoneyButton)
        case .wrong:
            view.addSubview(newGameButton)
        }
        
        NSLayoutConstraint.activate([
            millianaireImage.topAnchor.constraint(equalTo: view.topAnchor, constant: 50),
            millianaireImage.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            millianaireImage.heightAnchor.constraint(equalToConstant: 100),
            millianaireImage.widthAnchor.constraint(equalToConstant: 100),
            
            messageLabel.topAnchor.constraint(equalTo: millianaireImage.bottomAnchor, constant: 6),
            messageLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 15),
            messageLabel.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -15),
            messageLabel.heightAnchor.constraint(equalToConstant: 60),
            
            progressImageStackView.topAnchor.constraint(equalTo: messageLabel.bottomAnchor, constant: 6),
            progressImageStackView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 15),
            progressImageStackView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -15)
        ])
        
        switch answerStatus {
        
        case .right:
            NSLayoutConstraint.activate([
                takeMoneyButton.topAnchor.constraint(equalTo: progressImageStackView.bottomAnchor, constant: 20),
                takeMoneyButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -20),
                takeMoneyButton.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 15),
                takeMoneyButton.heightAnchor.constraint(equalToConstant: 40),
                
                nextQuestionButton.bottomAnchor.constraint(equalTo: takeMoneyButton.bottomAnchor),
                nextQuestionButton.leftAnchor.constraint(equalTo: takeMoneyButton.rightAnchor, constant: 20),
                nextQuestionButton.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -15),
                nextQuestionButton.heightAnchor.constraint(equalToConstant: 40),
                nextQuestionButton.widthAnchor.constraint(equalTo: takeMoneyButton.widthAnchor)
            ])
            
        case .wrong:
            NSLayoutConstraint.activate([
                newGameButton.topAnchor.constraint(equalTo: progressImageStackView.bottomAnchor, constant: 20),
                newGameButton.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 15),
                newGameButton.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -15),
                newGameButton.heightAnchor.constraint(equalToConstant: 40),
                newGameButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -20)
            ])
        }
    }
}

extension GameProgressViewController: CongratulationViewControllerDelegate {
    
    func restartFromCongratulation(dismiss: Void) {
        delegate?.restartGame()
        self.dismiss(animated: true)
        dismiss
    }
}
