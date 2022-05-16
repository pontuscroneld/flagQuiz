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
            case .done(let highscore, let onlineHighscore):
                Text("Loaded")
                
            }
            
//            List(viewModel.scores, id: \.self) { score in
//                Section(score.level.name) {
//                    Text("\(score.score)")
//                }
//            }
//            List(viewModel.onlineScores, id: \.self) { score in
//                Section(score.level.name) {
//                    Text("\(score.score)")
//                }
//            }
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

        ScoreView(viewModel: ScoreViewModel(state: .done(HighScore.mockHighscores(), HighScore.mockHighscores())))

    }
}
