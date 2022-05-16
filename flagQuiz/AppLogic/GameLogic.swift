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
    
    var path: String {
        switch self {
        case .easy:
            return "countriesEasy"
        case .hard:
            return "countries"
        case .europe:
            return "europe"
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
        }
    }
}

enum GameState {
    
    case start
    case playing
    case gameover
    
    var buttonMessage: String {
        switch self {
        case .start:
            return "Start"
        case .playing:
            return "Give up"
        case .gameover:
            return "Try again"

        }
    }
}
