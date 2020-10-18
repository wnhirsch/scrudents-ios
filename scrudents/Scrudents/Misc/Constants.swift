//
//  Constants.swift
//  Scrudents
//
//  Conjunto de valores constantes importantes para o
//  funcionamento do aplicativo.
//
//  Created by Wellington Nascente Hirsch on 16/10/20.
//

import Foundation

class Constants {
    
    struct Validations {
        static let minimumAge: Int = 6
        
        static let firstGrade: Int = 1
        static let lastGrade: Int = 9
        
        static let maxAddonChar: Int = 50
        static let maxCityChar: Int = 100
        static let maxDistrictChar: Int = 100
        static let maxNameChar: Int = 100
        static let maxStateChar: Int = 100
        static let maxStreetChar: Int = 120
        
        static let CEPRegex: String = "^\\d{5}-\\d{3}$"
        static let CEPPattern: String = "#####-###"
        static let CEPDigits: Int = 8
        static let CPFRegex: String = "^\\d{3}\\.\\d{3}\\.\\d{3}-\\d{2}$"
        static let CPFPattern: String = "###.###.###-##"
        static let CPFDigits: Int = 11
    }
    
}
