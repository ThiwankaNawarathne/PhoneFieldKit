//
//  PhoneFieldView.swift
//  PhoneFieldKit
//
//  Created by Thiwanka Nawarathne on 2024-04-29.
//

import SwiftUI

internal struct PhoneFieldView: View {
    @Binding var phoneNumber: String
    @Binding var isValidPhoneNumber: Bool
    @ObservedObject var model: PhoneFieldVM
    @FocusState private var keyIsFocused: Bool
    @State private var presentSheet = false
    
    @State var textColor: Color
    @State var borderColor: Color
    @State var borderRadius: Int
    @State var lineWidth: Int
    @State var fieldHeight: Int
    @State var maskChar: Character
    @State var prompt: String
    
    @State var borderColorCorrect: Color
    
    var body: some View {
        VStack {
            HStack {
                Button {
                    presentSheet = true
                    keyIsFocused = false
                } label: {
                    Image(model.selectedCountry?.code ?? "US", bundle: .module)
                        .resizable()
                        .frame(width: 25, height: 18)
                    
                    Text(model.selectedCountry?.dial_code ?? "")
                        .frame(height: CGFloat(fieldHeight))
                        .foregroundColor(textColor)
                }
                .padding(.trailing, 5)
                
                TextField(model.selectedCountry?.maskedPattern(with: maskChar) ?? "", text: $phoneNumber)
                    .focused($keyIsFocused)
                    .keyboardType(.numberPad)
                    .modifier(ClearButton(text: $phoneNumber))
                    .onChange(of: phoneNumber) { newValue in
                        phoneNumber = PhoneNumber.maskFormat(with: model.selectedCountry?.maskedPattern(with: maskChar) ?? "", phone: newValue, maskWith: maskChar)
                        if phoneNumber.filter({ $0.isNumber }).count <= (model.selectedCountry?.dial_code.filter({ $0.isNumber }).count ?? 0) {
                            let regex = try? NSRegularExpression(pattern: "[^0-9]+")
                            let matches = regex?.matches(in: newValue, options: [], range: NSRange(location: 0, length: newValue.count))
                            let count = matches?.count ?? 0
                            
                            if count != 0 {
                                phoneNumber = ""
                            } else {
                                phoneNumber =  newValue
                            }
                        }
                    }
                    .frame(height: CGFloat(fieldHeight))
                    .foregroundColor(textColor)
            }
            .onTapGesture {
                keyIsFocused = true
            }
            .padding(.top, 5)
            .padding(.bottom, 5)
            .padding(.leading, 10)
            .padding(.trailing, 10)
            .overlay(
                RoundedRectangle(cornerRadius: CGFloat(borderRadius))
                    .stroke(borderColor, lineWidth: CGFloat(lineWidth))
            )
            .sheet(isPresented: $presentSheet) {
                SearchView(phoneNumber: $phoneNumber, model: model, presentSheet: $presentSheet, maskChar: maskChar, prompt: prompt)
            }
            .presentationDetents([.medium, .large])
        }
        .padding()
        .toolbar {
            ToolbarItemGroup(placement: .keyboard) {
                Spacer()
                Button(action: {
                    keyIsFocused = false
                    validatePhoneNumber()
                }, label: {
                    Text("Done")
                        .fontWeight(.bold)
                })
            }
        }
    }
    
    private func validatePhoneNumber() {
        guard PhoneNumber.getValidNumber(phoneNumber: phoneNumber, countryCode: model.selectedCountry?.dial_code ?? "") != nil else {
            borderColor = .red
            return isValidPhoneNumber = false
        }
        borderColor = borderColorCorrect
        isValidPhoneNumber = true
    }
}
