//
//  PhoneNumber.swift
//  PhoneFieldKit
//
//  Created by Thiwanka Nawarathne on 2024-04-29.
//

import Foundation
import libPhoneNumber

internal struct PhoneNumber {
    enum PhoneNumberFormat: Int {
        case E164
        case International
        case National
        case RFC3966
    }
    
    static let defaultPhoneNumberFormat: PhoneNumberFormat = .E164
    static let formatingPatern:String = #"\+"#
    
    
    static func getValidNumber(phoneNumber: String, countryCode: String) -> NBPhoneNumber? {
        let libPhoneUtil: NBPhoneNumberUtil = NBPhoneNumberUtil()
        
        do {
            let parsedPhoneNumber: NBPhoneNumber = try libPhoneUtil.parse(countryCode + phoneNumber, defaultRegion: countryCode)
            let isValid = libPhoneUtil.isValidNumber(parsedPhoneNumber)
            
            return isValid ? parsedPhoneNumber : nil
        } catch _ {
            return nil
        }
    }
    
    static func maskFormat(with mask: String, phone: String, maskWith: Character) -> String {
        let numbers = phone.replacingOccurrences(of: "[^0-9]", with: "", options: .regularExpression)
        var result = ""
        var index = numbers.startIndex
        var maskIndex = mask.startIndex
        
        while index < numbers.endIndex && maskIndex < mask.endIndex {
            let maskChar = mask[maskIndex]
            let numberChar = numbers[index]
            
            if maskChar == maskWith {
                result.append(numberChar)
                index = numbers.index(after: index)
            } else {
                result.append(maskChar)
            }
            
            maskIndex = mask.index(after: maskIndex)
        }
        
        return result
    }
}
