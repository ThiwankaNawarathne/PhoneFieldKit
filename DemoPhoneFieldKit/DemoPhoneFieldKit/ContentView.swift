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
                Text("entered phone \(phoneNumber)")
                Text("is valid phone \(isValidPhoneNumber)")
                PhoneField(phoneNumber: $phoneNumber, isValidPhoneNumber: $isValidPhoneNumber, maskChar: "#", prompt: prompt, textColor: .secondary)
                //            PhoneField(phoneNumber: $phoneNumber, countries: countriesOnly, excludeInList: false)
            }
        }
        .toolbar {
            ToolbarItemGroup(placement: .keyboard) {
                Spacer()
                Button(action: {
                    
                }, label: {
                    Text("Done")
                        .fontWeight(.bold)
                })
            }
        }
    }
}

#Preview {
    ContentView()
}
