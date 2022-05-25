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
            HighScore(level: .europe, score: 20, type: .userEurope),
            HighScore(level: .asia, score: 55, type: .userAsia)
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
    case userAsia = 1111
    case onlineAsia = 2222
    case userSouth = 11111
    case onlineSouth = 22222
    case userNorth = 111111
    case onlineNorth = 222222
    
    var scoreType: String {
        switch self {
        case .userEasy, .userHard, .userEurope, .userAsia, .userSouth, .userNorth:
            return "User"
        case .onlineEasy, .onlineHard, .onlineEurope, .onlineAsia, .onlineSouth, .onlineNorth:
            return "World"
        }
    }
}


