//
//  StartView.swift
//  flagQuiz
//
//  Created by Pontus Croneld on 2022-05-01.
//

import SwiftUI

struct StartView: View {
    
    @ObservedObject var viewModel = StartViewModel()
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack {
                    Text("FLAGGY")
                        .font(.largeTitle)
                        .bold()
                        .foregroundColor(.orange)
                        .padding()
                    
                    LazyVGrid(columns: viewModel.items, spacing: 30) {
                        ForEach(DifficultyLevel.allCases, id: \.self) { level in
                            NavigationLink(
                                destination: GameView(viewModel: GameViewModel(difficulty: level))) {
                                    LevelView(level: level)
                                        .cornerRadius(20)
                                        .frame(
                                            width:UIScreen.main.bounds.width/2 - 20,
                                            height:UIScreen.main.bounds.width/3
                                        )
                                }
                                .padding(.horizontal)
                        }
                    }
                    
                    NavigationLink(
                        destination: ScoreView()
                    ) {
                        Text("Highscores")
                            .frame(width: 200, height: 50, alignment: .center)

                    }
                    .padding()
                    .buttonStyle(ColorFulButton(backgroundColor: .orange))
                }
            }
        }
    }
}

struct StartView_Previews: PreviewProvider {
    static var previews: some View {
        StartView()
    }
}
