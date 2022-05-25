//
//  FlagView.swift
//  flagQuiz
//
//  Created by Pontus Croneld on 2022-05-25.
//

import SwiftUI

struct FlagView: View {
    
    @State var flagList: [Country] = []

    
    var body: some View {
        
        List {
            ForEach(flagList, id: \.self) { country in
                HStack {
                    Text(country.name)
                    Spacer()
                    Text(country.flag).font(.largeTitle)
                }
            }
            
        }
    }
}

struct FlagView_Previews: PreviewProvider {
    static var previews: some View {
        FlagView()
    }
}
