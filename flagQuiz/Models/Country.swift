//
//  Country.swift
//  flagQuiz
//
//  Created by Pontus Croneld on 2022-04-28.
//

import Foundation

struct Country: Codable, Hashable {
    var code: String
    var emoji: String
    var unicode: String
    var name: String
    var title: String
    
    var flag: String {
        get {
            return code.unicodeScalars.compactMap { String.init(UnicodeScalar(UInt32(127397) + $0.value)!) }.joined()
        }
    }
}

struct CountryResponse: Codable {
    var countries: [Country]
}
