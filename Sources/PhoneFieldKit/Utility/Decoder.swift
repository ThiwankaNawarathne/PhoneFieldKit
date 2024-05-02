//
//  Decoder.swift
//  PhoneFieldKit
//
//  Created by Thiwanka Nawarathne on 2024-04-29.
//

import Foundation

class Decoder {
    static func decode<T: Decodable>(fileName: String) -> [T] {
        guard let fileURL = Bundle.module.url(forResource: fileName, withExtension: "json") else {
            fatalError("Failed to load file from bundle.")
        }
        
        guard let data = try? Data(contentsOf: fileURL) else {
            fatalError("Failed to load from bundle.")
        }
        
        let decoder = JSONDecoder()
        guard let decoded = try? decoder.decode([T].self, from: data) else {
            fatalError("Failed to decode from bundle.")
        }
        
        return decoded
    }
}
