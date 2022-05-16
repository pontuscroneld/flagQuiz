//
//  ScoreViewModel.swift
//  flagQuiz
//
//  Created by Pontus Croneld on 2022-05-06.
//

import Foundation
import SwiftUI
import FirebaseFirestore

class ScoreViewModel: ObservableObject {
    
    enum State {
        case loading
        case error
        case done([HighScore])
    }
    
    @ObservedObject var firebaseManager = FirebaseManager()
    @Published var scores: [HighScore] = []
    @Published var state: State
    
    let database = Firestore.firestore()
    
    init(state: State = .loading) {
        self.state = state
    }
    
    
    func onAppear() async {
        do {
            let onlineScores = try await firebaseManager.loadHighscores()
            self.scores = (onlineScores + loadLocalHighscores()).sorted {
                $0.type.rawValue < $1.type.rawValue
            }
            self.state = .done(scores)
        } catch {
            print(error.localizedDescription)
            self.state = .error
        }
    }
    
    func loadLocalHighscores() -> [HighScore] {
        var localHighscores: [HighScore] = []
        for level in DifficultyLevel.allCases {
            localHighscores.append(HighScore(level: level, score: UserDefaults.standard.integer(forKey: "highscore\(level.name)"), type: level.localType))
        }
        return localHighscores
    }
    
    func writeData(endpoint: Endpoint) {
        let docRef = database.document(endpoint.path)
        docRef.setData(["key": "value"])
    }
}


