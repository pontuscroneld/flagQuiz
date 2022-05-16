//
//  ColorfulButton.swift
//  flagQuiz
//
//  Created by Pontus Croneld on 2022-05-06.
//

import Foundation
import SwiftUI

struct ColorFulButton: ButtonStyle {
    
    var backgroundColor: Color

    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .background(backgroundColor)
            .foregroundColor(.white)
            .cornerRadius(15)
    }
}
