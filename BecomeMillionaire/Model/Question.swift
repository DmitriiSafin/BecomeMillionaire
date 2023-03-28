//
//  Question.swift
//  BecomeMillionaire
//
//  Created by Дмитрий on 28.03.2023.
//

import Foundation

struct Question: Decodable {
    let level: Int
    let ask: String
    let correctAnswer: String
    let wrongAnswers: [String]
    
    static func getQuestions() -> [Question] {
        if let url = Bundle.main.url(forResource: "questions", withExtension: "json") {
            do {
                let data = try Data(contentsOf: url)
                let decoder = JSONDecoder()
                let questions = try decoder.decode([Question].self, from: data)
                return questions
            } catch {
                print("Error data: \(error)")
            }
        }
        return []
    }
    
    func getAllAnswers() -> [String] {
        var allAnswers = wrongAnswers
        allAnswers.insert(correctAnswer, at: Int.random(in: 0..<wrongAnswers.count))
        return allAnswers
    }
    
    func getPrice(with level: Int) -> Int {
        switch level {
        case 1:
            return 100
        case 2:
            return 200
        case 3:
            return 300
        case 4:
            return 500
        case 5:
            return 1000
        case 6:
            return 2000
        case 7:
            return 4000
        case 8:
            return 8000
        case 9:
            return 16_000
        case 10:
            return 32_000
        case 11:
            return 64_000
        case 12:
            return 125_000
        case 13:
            return 250_000
        case 14:
            return 500_000
        case 15:
            return 1_000_000
        default:
            return 0
        }
    }
}
