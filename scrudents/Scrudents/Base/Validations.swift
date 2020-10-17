//
//  Validations.swift
//  Scrudents
//
//  Conjunto de extensões focadas na validação de atributos
//  de algumas entidades.
//
//  Created by Wellington Nascente Hirsch on 16/10/20.
//

import Foundation

//  MARK: - Date Validations
extension Date {
    
    func isValidPayday() -> Bool {
        return (self > Date())
    }
    
    func isValidBirthday() -> Bool {
        let myCalendar = Calendar.current
        var minimumDateComponents = myCalendar.dateComponents([.year, .month, .day], from: Date())
        
        if let actualYear = minimumDateComponents.year {
            minimumDateComponents.year = actualYear - Constants.Validations.minimumAge
            
            if let minimumDate = myCalendar.date(from: minimumDateComponents) {
                return (self <= minimumDate)
            }
        }
        
        return false
    }
    
}

//  MARK: - Int Validations
extension Int {
    
    func isValidGrade() -> Bool {
        return (self >= Constants.Validations.firstGrade && self <= Constants.Validations.lastGrade)
    }
    
}

//  MARK: - String Validations
extension String {
    
    func isValidName() -> Bool {
        return (self.count > 0 && self.count <= Constants.Validations.maxNameChar)
    }
    
    func isValidStreet() -> Bool {
        return (self.count > 0 && self.count <= Constants.Validations.maxStreetChar)
    }
    
    func isValidAddon() -> Bool {
        return (self.count > 0 && self.count <= Constants.Validations.maxAddonChar)
    }
    
    func isValidDistrict() -> Bool {
        return (self.count > 0 && self.count <= Constants.Validations.maxDistrictChar)
    }
    
    func isValidCity() -> Bool {
        return (self.count > 0 && self.count <= Constants.Validations.maxCityChar)
    }
    
    func isValidState() -> Bool {
        return (self.count > 0 && self.count <= Constants.Validations.maxStateChar)
    }
    
    func isValidCPF() -> Bool {
        let regex = try! NSRegularExpression(pattern: Constants.Validations.CPFFormat, options: .caseInsensitive)
        
        // FALSE se o CPF não possui o formato válido
        if regex.firstMatch(in: self, options: [], range: NSRange(location: 0, length: self.count)) == nil {
            return false
        }
        
        // Garante os 11 digitos
        var onlyDigits = self
        onlyDigits.removeAll(where: { $0 == "." || $0 == "-" } )
        
        let digitsArray: [Int] = Array(arrayLiteral: onlyDigits).compactMap( { Int($0) } )
        if digitsArray.count != Constants.Validations.CPFDigits {
            return false
        }
        
        // Verifica se o CPF não possui todos os digitos iguais (tal CPF passaria nos nossos testes)
        let firstDigit = digitsArray[0]
        var hasEqualDigits = true
        for digit in digitsArray {
            if digit != firstDigit {
                hasEqualDigits = false
                break
            }
        }
        
        if hasEqualDigits {
            return false
        }
        
        // Validamos o 1° digito verificador
        let firstChecker = digitsArray[9]
            
        var sumFirst = Int.zero
        for (index, digit) in digitsArray[0..<9].enumerated() {
            sumFirst += digit * (10 - index)
        }
        
        let firstRemainder = (sumFirst * 10) % 11
        if firstRemainder != firstChecker || (firstRemainder == 10 && firstChecker == 0) {
            return false
        }
        
        // Validamos o 2° digito verificador
        let secondChecker = digitsArray[10]
            
        var sumSecond = Int.zero
        for (index, digit) in digitsArray[0..<10].enumerated() {
            sumSecond += digit * (11 - index)
        }
        
        if (sumSecond * 10) % 11 != secondChecker {
            return false
        }
        else {
            return true
        }
    }
    
    func isValidCEP() -> Bool {
        let regex = try! NSRegularExpression(pattern: Constants.Validations.CEPFormat, options: .caseInsensitive)
        return regex.firstMatch(in: self, options: [], range: NSRange(location: 0, length: self.count)) != nil
    }
    
}
