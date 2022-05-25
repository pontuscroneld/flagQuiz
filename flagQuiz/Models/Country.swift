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

extension Country {
    static func mockCountries() -> [Country] {
        // Add some mock data here
        return [
            Country(code: "SE", emoji: "", unicode: "U+1F1F8 U+1F1EA", name: "Sweden", title: ""),
            Country(code: "SE", emoji: "", unicode: "U+1F1F8 U+1F1EA", name: "Sweden", title: ""),
            Country(code: "SE", emoji: "", unicode: "U+1F1F8 U+1F1EA", name: "Sweden", title: ""),
            Country(code: "SE", emoji: "", unicode: "U+1F1F8 U+1F1EA", name: "Sweden", title: ""),
        ]
    }
}

struct CountryResponse: Codable {
    var countries: [Country]
}
