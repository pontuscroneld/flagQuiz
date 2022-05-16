//
//  TimeBar.swift
//  flagQuiz
//
//  Created by Pontus Croneld on 2022-04-30.
//

import SwiftUI

struct TimeBar: View {
    @Binding var currentProgress: CGFloat
    
    var body: some View {
        ZStack(alignment: .leading) {
            RoundedRectangle(cornerRadius: 20)
                .foregroundColor(.gray.opacity(0.5))
                .frame(width: 300, height: 20, alignment: .center)
            RoundedRectangle(cornerRadius: 20)
                .foregroundColor(
                    barColor.opacity(0.5)
                )
                .frame(width: currentProgress * 30, height: 20, alignment: .leading)
        }
    }
    
    private var barColor: Color {
        if self.currentProgress < 3.0 {
            return .red
        } else if self.currentProgress < 6.0 {
            return .yellow
        } else {
            return .green
        }
    }
}
