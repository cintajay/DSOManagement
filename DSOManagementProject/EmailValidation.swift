//
//  EmailValidation.swift
//  DSOManagementProject
//
//  Created by user193960 on 11/15/22.
//

import Foundation

extension String {
    func isValidEmail() -> Bool {
        let regex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,6}"
        
        let emailTest = NSPredicate(format:"SELF MATCHES[c] %@", regex)
        return emailTest.evaluate(with: self)
    }
    var isValidURL: Bool {
        let detector = try! NSDataDetector(types: NSTextCheckingResult.CheckingType.link.rawValue)
        if let match = detector.firstMatch(in: self, options: [], range: NSRange(location: 0, length: self.utf16.count)) {
            // it is a link, if the match covers the whole string
            return match.range.length == self.utf16.count
        } else {
            return false
        }
    }
    var unescaped: String {
           let entities = ["\0", "\t", "\n", "\r", "\"", "\'", "\\"]
           var current = self
           for entity in entities {
            let descriptionCharacters = entity.debugDescription.dropFirst().dropLast()
               let description = String(descriptionCharacters)
               current = current.replacingOccurrences(of: description, with: entity)
           }
           return current
       }
    
}

