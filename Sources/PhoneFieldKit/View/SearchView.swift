//
//  SearchView.swift
//  PhoneFieldKit
//
//  Created by Thiwanka Nawarathne on 2024-04-29.
//

import SwiftUI

internal struct SearchView: View {
    @Binding var phoneNumber: String
    @ObservedObject var model: PhoneFieldVM
    @Binding var presentSheet: Bool
    @State private var searchCountry: String = ""
    @State var maskChar: Character
    @State var prompt: String = ""
    
    private var filteredCountries: [CountryData] {
        if searchCountry.isEmpty {
            return model.countries
        } else {
            return model.countries.filter { $0.name.range(of: searchCountry, options: .caseInsensitive) != nil }
        }
    }
    
    var body: some View {
        NavigationView {
            VStack {
                SearchFieldView(searchCountry: $searchCountry, prompt: $prompt)
                
                List(filteredCountries) { country in
                    VStack {
                        HStack {
                            Image(country.code, bundle: .module)
                                .resizable()
                                .frame(width: 20, height: 14)
                                .padding(.trailing, 5)
                            Text(country.name)
                                .font(.subheadline)
                                .foregroundColor(.primary)
                            Spacer()
                            Text(country.dial_code)
                                .font(.subheadline)
                                .foregroundColor(.secondary)
                        }
                        .contentShape(Rectangle())
                        Divider()
                    }
                    .onTapGesture {
                        model.selectedCountry = country
                        phoneNumber = PhoneNumber.maskFormat(with: model.selectedCountry?.maskedPattern(with: maskChar) ?? "", phone: phoneNumber, maskWith: maskChar)
                        presentSheet = false
                        searchCountry = ""
                    }
                    .listRowSeparator(.hidden)
                    .padding(0)
                }
                .scrollIndicators(ScrollIndicatorVisibility.hidden)
                .padding(0)
                .padding(.top, 10)
                .listStyle(.plain)
            }
            .padding(.top, 20)
            .padding(.leading, 15)
            .padding(.trailing, 15)
        }
        .presentationDetents([.medium, .large])
        .presentationDragIndicator(.visible)
    }
}
