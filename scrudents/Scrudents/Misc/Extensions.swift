//
//  Extensions.swift
//  Scrudents
//
//  Created by Wellington Nascente Hirsch on 17/10/20.
//

import Foundation
import UIKit

// MARK: - Date extensions
extension Date {
    
    static let Second:  TimeInterval = 1
    static let Minute:  TimeInterval = 60
    static let Hour:    TimeInterval = (60 * 60)
    static let Day:     TimeInterval = (24 * 60 * 60)
    static let Week:    TimeInterval = (7 * 24 * 60 * 60)
    static let Month:   TimeInterval = (30 * 24 * 60 * 60)
    static let Year:    TimeInterval = (365 * 24 * 60 * 60)
    
    var day: Int {
        return Calendar.current.component(.day, from: self)
    }
    
    var month: Int {
        return Calendar.current.component(.month, from: self)
    }
    
    var monthDescription: String {
        let dateFormatter = DateFormatter()
        dateFormatter.setLocalizedDateFormatFromTemplate("MMM")
        return dateFormatter.string(from: self).capitalized
    }
    
    var year: Int {
        return Calendar.current.component(.year, from: self)
    }
    
    var hour: Int {
        return Calendar.current.component(.hour, from: self)
    }
    
    var minute: Int {
        return Calendar.current.component(.minute, from: self)
    }
}

// MARK: - String extensions
extension String {
    
    var localized: String {
        return NSLocalizedString(self, comment: "")
    }
    
    func localized(_ arguments: CVarArg...) -> String {
        return String(format: self.localized, arguments: arguments)
    }
    
    func applyPatternOnNumbers(pattern: String) -> String {
        let stringArray = Array(self)
        let digitsArray: [Int] = stringArray.compactMap( { Int(String($0)) } )
        let patternArray = Array(pattern)
        
        var result: String = String()
        var digitIndex: Int = Int.zero
        
        for char in patternArray {
            if char == "#" {
                if digitIndex < digitsArray.count {
                    result.append(String(digitsArray[digitIndex]))
                    digitIndex += 1
                    if digitIndex == digitsArray.count {
                        return result
                    }
                }
                else {
                    return result
                }
            }
            else {
                result.append(char)
            }
        }
        
        return result
    }
    
}

// MARK: - UITextField extensions
extension UITextField {
    
    func setErrorState(hasError: Bool) {
        if hasError {
            self.textColor = UIColor.red
            self.layer.borderColor = UIColor.red.cgColor
        }
        else {
            self.textColor = UIColor.label
            self.layer.borderColor = UIColor.placeholderText.cgColor
        }
    }
    
}

// MARK: - UIViewController extensions
extension UIViewController {
    
    func hideKeyboardWhenTappedAround() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
    
}
