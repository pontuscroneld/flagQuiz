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
        case done([HighScore], [HighScore])
    }
    
    @Published var scores: [HighScore] = []
    @Published var onlineScores: [HighScore] = []
    @Published var fbText: String = ""
    @ObservedObject var firebaseManager = FirebaseManager()
    
    @Published var state: State = .loading
    
    init(state: State = .loading) {
        self.state = state
    }
    
    let database = Firestore.firestore()
    
    func onAppear() async {
        
        do {
            onlineScores = try await firebaseManager.loadHighscores()
            loadHighscores()
        } catch {
            print(error.localizedDescription)
        }
    }
    
    func loadHighscores() {
        var temp: [HighScore] = []
        for level in DifficultyLevel.allCases {
            temp.append(HighScore(level: level, score: UserDefaults.standard.integer(forKey: "highscore\(level.name)"), type: .user))
        }
        self.scores = temp
    }
    
    func writeData(endpoint: Endpoint) {
        let docRef = database.document(endpoint.path)
        docRef.setData(["key": "value"])
    }
}


