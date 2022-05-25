//
//  GameLogic.swift
//  flagQuiz
//
//  Created by Pontus Croneld on 2022-05-02.
//

import Foundation

enum DifficultyLevel: String, CaseIterable {
    case easy
    case hard
    case europe
    case asia
    
    var path: String {
        switch self {
        case .easy:
            return "countriesEasy"
        case .hard:
            return "countries"
        case .europe:
            return "europe"
        case .asia:
            return "asia"
        }
    }
    
    var name: String {
        switch self {
        case .easy:
            return "Easy"
        case .hard:
            return "Hard"
        case .europe:
            return "Europe"
        case .asia:
            return "Asia"
        }
    }
    
    var endpoint: String {
        switch self {
        case .easy:
            return Endpoint.highscoreEurope.path
        case .hard:
            return Endpoint.highscoreHard.path
        case .europe:
            return Endpoint.highscoreEurope.path
        case .asia:
            return Endpoint.highscoreAsia.path
        }
    }
    
    var localType: HighScoreType {
        switch self {            
        case .easy:
            return .userEasy
        case .hard:
            return .userHard
        case .europe:
            return .userEurope
        case .asia:
            return .userAsia
        }
    }
    
    var onlineType: HighScoreType {
        switch self {
        case .easy:
            return .onlineEasy
        case .hard:
            return .onlineHard
        case .europe:
            return .onlineEurope
        case .asia:
            return .onlineAsia
        }
    }
    
    var localHighscore: HighScore {
        return HighScore(level: .easy, score: findLocalHighscore(level: self.name), type: self.localType)
    }
    
    func findLocalHighscore(level: String) -> Int {
        return UserDefaults.standard.integer(forKey: "highscore\(level)")
    }
}

