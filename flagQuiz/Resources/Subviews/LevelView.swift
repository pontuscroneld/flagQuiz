//
//  LevelView.swift
//  flagQuiz
//
//  Created by Pontus Croneld on 2022-05-25.
//

import SwiftUI

struct LevelView: View {
    
    var level: DifficultyLevel
    
    var body: some View {
        ZStack {
            
            Image(level.image)
                .resizable()
                .aspectRatio(contentMode: .fit)
                
        
            VStack {
                Spacer()
                Text(level.name)
                    .frame(maxWidth: .infinity, alignment: .trailing)
                    .padding()
                    .font(.subheadline)
                    .background(.yellow)
                    .foregroundColor(.white)
            }
        }.overlay(RoundedRectangle(cornerRadius: 20)
            .stroke(Color.primary, lineWidth: 5)
        )
    }
}

struct LevelView_Previews: PreviewProvider {
    static var previews: some View {
        LevelView(level: .easy)
    }
}
