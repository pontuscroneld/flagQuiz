//
//  Highscore.swift
//  flagQuiz
//
//  Created by Pontus Croneld on 2022-05-13.
//

import Foundation

struct HighScore: Hashable {
    var level: DifficultyLevel
    var score: Int
    var type: HighScoreType
    
    static func mockHighscores() -> [HighScore] {
        // Add some mock data here
        return [
            HighScore(level: .easy, score: 100, type: .userEasy),
            HighScore(level: .hard, score: 70, type: .userHard),
            HighScore(level: .europe, score: 20, type: .userEurope)
        ]
    }
}

enum HighScoreType: Int {
    case userEasy = 1
    case onlineEasy = 2
    case userHard = 11
    case onlineHard = 22
    case userEurope = 111
    case onlineEurope = 222

}


