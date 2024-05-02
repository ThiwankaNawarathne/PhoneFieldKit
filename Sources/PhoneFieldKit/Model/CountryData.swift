//
//  CountryData.swift
//  PhoneFieldKit
//
//  Created by Thiwanka Nawarathne on 2024-04-29.
//

import Foundation

struct CountryData: Codable, Identifiable {
    let id: String
    let name: String
    let code: String
    let dial_code: String
    let pattern: String
    
    func maskedPattern(with: Character) -> String {
        pattern.replacingOccurrences(of: "X", with: String(with))
    }
}
