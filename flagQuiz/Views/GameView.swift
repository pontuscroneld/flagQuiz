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
    @State var navigate: Bool = false

    var body: some View {
        ZStack {
            if viewModel.showConfetti {
                Circle()
                    .fill(Color.blue)
                    .frame(width: 12, height: 12)
                    .modifier(ParticlesModifier())
                    .offset(x: -100, y : -50)
                
                Circle()
                    .fill(Color.red)
                    .frame(width: 12, height: 12)
                    .modifier(ParticlesModifier())
                    .offset(x: 60, y : 70)
            }
            
            switch viewModel.newState {
            case .start, .finished:
                VStack {
                    
                    Text(viewModel.level.name)
                    Text("Highscore: \(viewModel.level.localHighscore.score)")
                    
                    Button(action: {
                        viewModel.triggerGame()
                    }){
                        Text(viewModel.newState.buttonMessage)
                            .frame(width: 200, height: 44, alignment: .center)
                    }
                    .buttonStyle(ColorFulButton(
                        backgroundColor: viewModel.newState != .playing ? .green : .red))
                    
                    Button(action: {
                        navigate.toggle()
                    }){
                        Text("See countries")
                            .frame(width: 200, height: 44, alignment: .center)
                    }
                    .buttonStyle(ColorFulButton(
                        backgroundColor: .yellow))
                    
                    
                    Button(action: { presentationMode.wrappedValue.dismiss() }){
                        Text("Go back").frame(width: 200, height: 44, alignment: .center)
                    }
                    .buttonStyle(ColorFulButton(backgroundColor: .orange))
                }.onAppear {
                    self.navigate = false
                }
                .background(
                    NavigationLink(
                        destination: FlagView(flagList: viewModel.countries),
                        isActive: $navigate) {
                        EmptyView()
                    }
                    .hidden()
                )
            case .failed:
                Text("ERROR")
                
            case .playing:
                VStack {
                    Text("Score: \(viewModel.score)")
                    Text(viewModel.selectedCountry.flag)
                        .font(.system(size: 100))
                    
                    TimeBar(currentProgress: $viewModel.timerProgress)
                    
                    LazyVGrid(columns: viewModel.items, spacing: 10) {
                        ForEach(viewModel.answers, id: \.self) { answer in
                            Button(action: {
                               viewModel.validateAnswer(pressedAnswer: answer) }) {
                                Text(answer.name).bold()
                                    .frame(
                                        width:UIScreen.main.bounds.width/2 - 30,
                                        height:UIScreen.main.bounds.width/3
                                    )
                            }.buttonStyle(AnswerButton())
                        }
                    }
                    
                    Button(action: {
                        viewModel.triggerGame()
                    }){
                        Text(viewModel.newState.buttonMessage)
                            .frame(width: 200, height: 44, alignment: .center)
                    }
                    .buttonStyle(ColorFulButton(
                        backgroundColor: viewModel.newState != .playing ? .green : .red))
                    
                    
                }
            }
        }.navigationBarHidden(true)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        GameView(viewModel: GameViewModel(difficulty: .easy))
    }
}
