//
//  ContentView.swift
//  DemoPhoneFieldKit
//
//  Created by Thiwanka Nawarathne on 2024-05-02.
//

import SwiftUI
import PhoneFieldKit

struct ContentView: View {
    @State var phoneNumber: String = ""
    @State var isValidPhoneNumber: Bool = false
    
    var countriesOnly: [String] = ["LK", "US", "GB"]
    
    var prompt: String = "Search Your Country"
    
    var body: some View {
        NavigationView {
            VStack {
                Text("Phone Number \(phoneNumber)")
                Text("Valid Phone Number \(isValidPhoneNumber)")
                PhoneField(phoneNumber: $phoneNumber, isValidPhoneNumber: $isValidPhoneNumber, maskChar: "#", prompt: prompt, textColor: .secondary)
            }
        }
        .dismissKeyBoard()
    }
}

#Preview {
    ContentView()
}
