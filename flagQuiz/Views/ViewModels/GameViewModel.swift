//
//  JsonManager.swift
//  flagQuiz
//
//  Created by Pontus Croneld on 2022-04-28.
//

import Foundation
import SwiftUI
import FirebaseFirestore

class GameViewModel: ObservableObject {
    enum State {
        case start
        case failed(Error)
        case loaded([Country])
        case finished(Int)
    }
    
    @Published var countries: [Country] = []
    @Published var selectedCountry: Country = Country(code: "", emoji: "", unicode: "", name: "", title: "")
    @Published var answers: [Country] = []
    @Published var score: Int = 0
    @Published var timerProgress: CGFloat = 10.0
    @Published var gameState: GameState = .start
    @Published var level: DifficultyLevel
    private var questionsAnswered: CGFloat = 0.0
    let database = Firestore.firestore()
    
    var items: [GridItem] = Array(repeating: .init(.flexible()), count: 2)
    
    init(difficulty: DifficultyLevel) {
        level = difficulty
        countries = load(path: difficulty.path)
    }
    
    func startGame() {
        gameState = .playing
        setupQuestion()
        startTimer()
    }
    
    func stopGame() {
        checkHighscore(difficulty: level, score: score)
        gameState = .gameover
        questionsAnswered = 0
        score = 0
    }
    
    func triggerGame() {
        switch gameState {
        case .playing:
            stopGame()
        default:
            startGame()
        }
    }
    
    func setupQuestion() {
        answers.removeAll()
        selectedCountry = randomizeCountry(countries: countries, isCorrectAnswer: true)
        let wrongAnswers = createWrongAnswers()
        answers.append(contentsOf: [selectedCountry, wrongAnswers[0], wrongAnswers[1], wrongAnswers[2]].shuffled())
        }
    
    func startTimer() {
        _ = Timer.scheduledTimer(withTimeInterval: 0.2, repeats: true) { timer in
                    withAnimation() {
                        if self.gameState == .gameover {
                            timer.invalidate()
                            self.timerProgress = 10.0
                        }
                        let timerDecrease = (0.1 + CGFloat(self.questionsAnswered/20))
                        self.timerProgress -= timerDecrease
                        if self.timerProgress <= 0.0 {
                            self.gameState = .gameover
                            self.stopGame()
                            timer.invalidate()
                            self.timerProgress = 10.0
                            self.setupQuestion()
                        }
                    }
                }
    }
    
    func validateAnswer(pressedAnswer: Country) {
        if pressedAnswer == selectedCountry {
            score += Int(timerProgress)
        } else {
            score -= Int(timerProgress)
            if score <= 0 {
                score = 0
            }
        }
        questionsAnswered += 1.0
        setupQuestion()
        self.timerProgress = 10.0
    }
    
    func load(path: String) -> [Country] {
        
        guard let filePath = Bundle.main.path(forResource: path, ofType: "json") else { return [] }
        do {
            let data = try Data(contentsOf: URL(fileURLWithPath: filePath))
            return try JSONDecoder().decode(CountryResponse.self, from: data).countries
        } catch {
            print(error.localizedDescription)
            return []
        }
    }
    
    func createWrongAnswers() -> [Country] {
        var wrongAnswers: [Country] = []
        var filteredCountries: [Country] = countries
        for _ in 0...2 {
            let wrongCountry = randomizeCountry(countries: filteredCountries, isCorrectAnswer: false)
            if let index = filteredCountries.firstIndex(of: wrongCountry) {
                filteredCountries.remove(at: index)
            }
            wrongAnswers.append(wrongCountry)
        }
        return wrongAnswers
    }
    
    func randomizeCountry(countries: [Country], isCorrectAnswer: Bool) -> Country {
        let mockCountry = Country(code: "", emoji: "", unicode: "", name: "", title: "")
        if !isCorrectAnswer {
            let wrongAnswers = countries.filter {
                $0.title != selectedCountry.title
            }
            return wrongAnswers.randomElement() ?? mockCountry
        }
        return countries.randomElement() ?? mockCountry
    }
    
    func checkHighscore(difficulty: DifficultyLevel, score: Int) {
        
        let highscore = UserDefaults.standard.integer(forKey: "highscore\(difficulty.name)")
        if score > highscore {
            UserDefaults.standard.set(score, forKey: "highscore\(difficulty.name)")
            
            var endpoint = ""
            
            switch self.level {
            case .easy:
                endpoint = Endpoint.highscoreEasy.path
            case .hard:
                endpoint = Endpoint.highscoreHard.path
            case .europe:
                endpoint = Endpoint.highscoreEurope.path
            }
            
            let docRef = database.document(endpoint)
            docRef.setData(["Score": score])
        }
    }
}

extension GameViewModel {
    var decoder: JSONDecoder {
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .iso8601
        return decoder
    }
}



