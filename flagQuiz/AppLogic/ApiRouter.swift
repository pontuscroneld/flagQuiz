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
