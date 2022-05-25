//
//  ApiRouter.swift
//  flagQuiz
//
//  Created by Pontus Croneld on 2022-05-12.
//

import Foundation

enum Endpoint {
    case highscoreEasy
    case highscoreHard
    case highscoreEurope
    case highscoreAsia
    case highscoreSouth
    case highscoreNorthCentral
}

extension Endpoint {
    var path: String {
        switch self {
        case .highscoreEasy:
            return String.makeForEndpoint("easy")
        case .highscoreHard:
            return String.makeForEndpoint("hard")
        case .highscoreEurope:
            return String.makeForEndpoint("europe")
        case .highscoreAsia:
            return String.makeForEndpoint("asia")
        case .highscoreSouth:
            return String.makeForEndpoint("south")
        case .highscoreNorthCentral:
            return String.makeForEndpoint("northcentral")
        }
    }
}

private extension String {
    static private var baseURL: String {
           "highscore/"
       }
    
    static func makeForEndpoint(_ endpoint: String) -> String {
        "\(baseURL)\(endpoint)"
    }
}
