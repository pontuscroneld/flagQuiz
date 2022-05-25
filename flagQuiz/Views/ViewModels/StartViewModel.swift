//
//  StartViewModel.swift
//  flagQuiz
//
//  Created by Pontus Croneld on 2022-05-25.
//

import Foundation
import SwiftUI

class StartViewModel: ObservableObject {
    var items: [GridItem] = Array(repeating: .init(.flexible()), count: 2)

}
