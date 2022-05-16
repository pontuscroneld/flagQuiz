//
//  APIrouter.swift
//  flagQuiz
//
//  Created by Pontus Croneld on 2022-05-11.
//

import Foundation
import FirebaseFirestore

enum NetworkError: Error {
    case loadingError
}


protocol NetworkManager {
    func loadHighscores() async throws -> [HighScore]
    func write(endpoint: Endpoint, newScore: Int)
    func snapshotListener(endpoint: Endpoint)
    func findCollection(collection: String) async throws -> [QueryDocumentSnapshot]
}

class FirebaseManager: NetworkManager, ObservableObject {
    
    let database = Firestore.firestore()
    var message: String = ""
    
    func loadHighscores() async throws -> [HighScore] {

        return try await findCollection(collection: "highscore").map { item in
            guard let level = DifficultyLevel(rawValue: item.documentID) else { fatalError() }
            let score = item.data().first?.value as? Int ?? 0
            return HighScore(level: level, score: score, type: level.onlineType)
        }
    }
    
    func findCollection(collection: String) async throws -> [QueryDocumentSnapshot] {
        let snapshot = try await database.collection(collection).getDocuments()
        let docs = try? snapshot.documents
        guard let loadedDocs = docs else { return [] }
        return loadedDocs
    }
    
    func write(endpoint: Endpoint, newScore: Int) {
        let docRef = database.document(endpoint.path)
        docRef.setData(["key": "\(newScore)"])
    }
    
    func snapshotListener(endpoint: Endpoint) {
        let docRef = database.document(endpoint.path)

        docRef.addSnapshotListener { snapshot, error in
            guard let data = snapshot?.data(), error == nil else { return }
            print(data)
            guard let text = data["key"] as? String else { return }
            
        }
    }
}
