//
//  AnswerButton.swift
//  flagQuiz
//
//  Created by Pontus Croneld on 2022-05-06.
//

import Foundation
import SwiftUI

struct AnswerButton: ButtonStyle {
    
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .background(.green)
            .cornerRadius(10)
            .foregroundColor(.white)
            .overlay(
                RoundedRectangle(cornerRadius: 10)
                    .stroke(Color.gray, lineWidth: 2).opacity(0.2)
                    .shadow(color: .black, radius: 10, y: 5)
            )
    }
}
