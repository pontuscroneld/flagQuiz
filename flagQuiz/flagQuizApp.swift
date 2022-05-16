//
//  flagQuizApp.swift
//  flagQuiz
//
//  Created by Pontus Croneld on 2022-04-28.
//

import SwiftUI
import Firebase

@main
struct flagQuizApp: App {
    
    init() {
        FirebaseApp.configure()
      }
    
    var body: some Scene {
        WindowGroup {
            StartView()
        }
    }
}
