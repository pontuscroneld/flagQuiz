//
//  ContentView.swift
//  flagQuiz
//
//  Created by Pontus Croneld on 2022-04-28.
//

import SwiftUI

struct GameView: View {
    
    @ObservedObject var viewModel = GameViewModel(difficulty: .easy)
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>

    var body: some View {
        VStack {
             Spacer()
            VStack {
                Text(viewModel.level.name).font(.largeTitle)
                Text("Highscore: \(viewModel.level.highscore.score)")
            }
            
            VStack {
                Text("Score: \(viewModel.score)")
                Text(viewModel.selectedCountry.flag)
                    .font(.system(size: 100))
                
                TimeBar(currentProgress: $viewModel.timerProgress)
                
                answerGrid
                
            }
            .isHidden(viewModel.gameState == .start || viewModel.gameState == .gameover, remove: true)
            
            dualButtons
            
            Spacer()
            
        }
        .navigationBarHidden(true)
        .frame(maxWidth: .infinity)
    }
    
    var answerGrid: some View {
        LazyVGrid(columns: viewModel.items, spacing: 10) {
            ForEach(viewModel.answers, id: \.self) { answer in
                Button(action: { viewModel.validateAnswer(pressedAnswer: answer) }) {
                    Text(answer.name).bold()
                        .frame(
                            width:UIScreen.main.bounds.width/2 - 30,
                            height:UIScreen.main.bounds.width/3
                        )
                }.buttonStyle(AnswerButton())
            }
        }
    }
    
    var dualButtons: some View {
        VStack {
            Button(action: {
                viewModel.triggerGame()
            }){
                Text(viewModel.gameState.buttonMessage)
                    .frame(width: 200, height: 44, alignment: .center)
            }
            .buttonStyle(ColorFulButton(
                backgroundColor: viewModel.gameState != .playing ? .green : .red))
            
            Button(action: { presentationMode.wrappedValue.dismiss() }){
                Text("Go back").frame(width: 200, height: 44, alignment: .center)
            }
            .buttonStyle(ColorFulButton(backgroundColor: .orange))
            .isHidden(viewModel.gameState == .playing)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        GameView(viewModel: GameViewModel(difficulty: .easy))
    }
}
