//
//  PhoneFieldVM.swift
//  PhoneFieldKit
//
//  Created by Thiwanka Nawarathne on 2024-04-29.
//

import Foundation

@MainActor
internal final class PhoneFieldVM: ObservableObject {
    @Published var selectedCountry: CountryData? = nil
    @Published var countries: [CountryData] = []
    @Published var filteredCountries: [CountryData] = []
    
    private var countriesDecoded: [CountryData] = Decoder.decode(fileName: "CountryNumbers")
    
    public init(list: [String] = [], selectedDefault: String? = nil, exclude: Bool = false) {
        Task {
            await setCurrentCountry(defaultCountry: selectedDefault)
            await getCountries(with: list, defaultCountry: selectedDefault, excludeInList: exclude)
        }
    }
    
    private func getCountries(with list: [String], defaultCountry: String?, excludeInList: Bool) async {
        guard list.count > 0 else {
            return countries = countriesDecoded
        }
        
        if excludeInList {
            countries =  countriesDecoded.filter({ !list.contains($0.code) })
        } else {
            countries =  countriesDecoded.filter({ list.contains($0.code) })
        }
    }
    
    private func setCurrentCountry(defaultCountry: String? = nil) async {
        let region = defaultCountry != nil ? defaultCountry : Locale.current.region?.identifier ?? "US"
        selectedCountry = countriesDecoded.first(where: {$0.code == region}) ?? countriesDecoded.first!
    }
}
