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
        return []
    }
}

enum HighScoreType {
    case user
    case online
}


