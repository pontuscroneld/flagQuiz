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
    case south
    case northcentral
    
    var image: String {
        switch self {
        case .easy:
            return "easy"
        case .hard:
            return "hard"
        case .europe:
            return "europe"
        case .asia:
            return "asia"
        case .south:
            return "south"
        case .northcentral:
            return "north"
        }
    }
    
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
        case .south:
            return "south"
        case .northcentral:
            return "northcentral"
        }
    }
    
    var name: String {
        switch self {
        case .easy:
            return "Easy"
        case .hard:
            return "Whole World"
        case .south:
            return "South America"
        case .northcentral:
            return "North/Central America"
        case .europe:
            return "Europe"
        case .asia:
            return "Asia"
        }
    }
    
    var endpoint: String {
        switch self {
        case .south:
            return Endpoint.highscoreSouth.path
        case .northcentral:
            return Endpoint.highscoreNorthCentral.path
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
        case .south:
            return .userSouth
        case .northcentral:
            return .userNorth
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
        case .south:
            return .onlineSouth
        case .northcentral:
            return .onlineNorth
        }
    }
    
    var localHighscore: HighScore {
        return HighScore(level: .easy, score: findLocalHighscore(level: self.name), type: self.localType)
    }
    
    func findLocalHighscore(level: String) -> Int {
        return UserDefaults.standard.integer(forKey: "highscore\(level)")
    }
}

