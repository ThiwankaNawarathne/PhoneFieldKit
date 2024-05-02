//
//  ClearButton.swift
//  PhoneFieldKit
//
//  Created by Thiwanka Nawarathne on 2024-04-29.
//

import SwiftUI

public struct SearchFieldView: View {
    @Binding private var searchCountry: String
    @Binding var prompt: String
    
    public init(searchCountry: Binding<String>, prompt: Binding<String>) {
        _searchCountry = searchCountry
        _prompt = prompt
    }
    
    public var body: some View {
        HStack {
            Image(systemName: "magnifyingglass")
                .foregroundColor(.secondary.opacity(0.5))
            TextField(prompt, text: $searchCountry)
                .modifier(ClearButton(text: $searchCountry))
                .font(.subheadline)
                .foregroundColor(.secondary.opacity(0.7))
                .autocorrectionDisabled(true)
                .keyboardType(.alphabet)
                .textContentType(.init(rawValue: ""))
        }
        .padding(7)
        .background(Color.secondary.opacity(0.1))
        .cornerRadius(50)
    }
}
