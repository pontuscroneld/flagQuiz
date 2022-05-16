//
//  StartView.swift
//  flagQuiz
//
//  Created by Pontus Croneld on 2022-05-01.
//

import SwiftUI

struct StartView: View {
    var body: some View {
        NavigationView {
            VStack {
                Text("Flag Quiz").font(.largeTitle)
                    .padding()
                HStack {
                    ForEach(DifficultyLevel.allCases, id: \.self) { level in
                        NavigationLink(
                            level.name,
                            destination: GameView(viewModel: GameViewModel(difficulty: level))
                        ).buttonStyle(.bordered)
                            .padding(3)
                    }
                }
                NavigationLink(
                    "Highscores",
                    destination: ScoreView()
                ).buttonStyle(.bordered)
                    .padding(3)
            }
        }
    }
}

struct StartView_Previews: PreviewProvider {
    static var previews: some View {
        StartView()
    }
}
