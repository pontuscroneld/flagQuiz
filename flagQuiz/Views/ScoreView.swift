//
//  ScoreView.swift
//  flagQuiz
//
//  Created by Pontus Croneld on 2022-05-06.
//

import SwiftUI

struct ScoreView: View {
    
    @ObservedObject var viewModel = ScoreViewModel()
    
    var body: some View {
        VStack {
            
            switch viewModel.state {
                
            case .loading:
                ProgressView("Loading")
            case .error:
                Text("Error")
            case .done(let highscores):
               
                List {
                    ForEach(DifficultyLevel.allCases, id: \.self) { level in
                        Section(level.name) {
                            ForEach(viewModel.scores.filter { $0.level.rawValue == level.rawValue }, id: \.self) { score in
                                Text("\(score.type.rawValue)")
                            }
                        }
                    }
                }
            }
        }
        .navigationBarTitleDisplayMode(.inline)
        .onAppear {
            Task {
                await viewModel.onAppear()
            }
        }
    }
}

struct ScoreView_Previews: PreviewProvider {
    static var previews: some View {
        ScoreView()
        ScoreView(viewModel: ScoreViewModel(state: .error))
        ScoreView(viewModel: ScoreViewModel(state: .done(HighScore.mockHighscores())))
    }
}
