//
//  PhoneFieldKit.swift
//  PhoneFieldKit
//
//  Created by Thiwanka Nawarathne on 2024-04-29.
//

import SwiftUI

public struct PhoneField: View {
    @StateObject private var model: PhoneFieldVM
    @State private var phoneNumberEntered: String = ""
    
    @Binding var phoneNumber: String
    @Binding var isValidPhoneNumber: Bool
    @State var textColor: Color = .secondary
    @State var borderColor: Color = .secondary
    @State var borderRadius: Int = 0
    @State var lineWidth: Int = 0
    @State var fieldHeight: Int = 0
    @State var maskChar: Character
    @State var prompt: String = ""
    
    public init(phoneNumber: Binding<String>, isValidPhoneNumber: Binding<Bool>, countries list: [String] = [], defaultCountry selectedDefault: String? = nil, excludeInList exclude: Bool = false, maskChar mask: Character = "X", prompt myPrompt: String = "Search Your Country", textColor colorText: Color = .primary, fieldHeight heightOfField: Int = 40, borderColor color: Color = .secondary, borderRadius radius: Int = 8, lineWidth width: Int = 1) {
        _phoneNumber = phoneNumber
        _isValidPhoneNumber = isValidPhoneNumber
        maskChar = mask
        prompt = myPrompt
        fieldHeight = heightOfField
        borderColor = color
        lineWidth = width
        borderRadius = radius
        textColor = colorText
        _model = StateObject(wrappedValue: PhoneFieldVM(list: list, selectedDefault: selectedDefault, exclude: exclude))
    }
    
    public var body: some View {
        VStack {
            PhoneFieldView(phoneNumber: $phoneNumberEntered, isValidPhoneNumber: $isValidPhoneNumber, model: model, textColor: textColor, borderColor: borderColor, borderRadius: borderRadius, lineWidth: lineWidth, fieldHeight: fieldHeight, maskChar: maskChar, prompt: prompt, borderColorCorrect: borderColor)
                .onChange(of: phoneNumberEntered) { value in
                    guard let dialCode = model.selectedCountry?.dial_code else {
                        return
                    }
                    
                    phoneNumber = dialCode + value
                }
        }
    }
}

internal struct keyboard: ViewModifier {
    func body(content: Content) -> some View {
        content
            .onTapGesture {
                let keyWindow = UIApplication.shared.connectedScenes
                        .filter({$0.activationState == .foregroundActive})
                        .map({$0 as? UIWindowScene})
                        .compactMap({$0})
                        .first?.windows
                        .filter({$0.isKeyWindow}).first
                keyWindow?.endEditing(true)
        }
    }
}

extension View {
    public func dismissKeyBoard() -> some View {
        modifier(keyboard())
    }
}
