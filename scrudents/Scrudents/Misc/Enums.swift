//
//  Enums.swift
//  Scrudents
//
//  Created by Wellington Nascente Hirsch on 17/10/20.
//

import Foundation

@objc enum Grade: Int, RawRepresentable, CustomStringConvertible, CaseIterable {
    
    typealias RawValue = Int
    
    case first
    case second
    case third
    case fourth
    case fifth
    case sixth
    case seventh
    case eighth
    case ninth
    
    var rawValue: Int {
        switch self {
            case .first:
                return 1
            case .second:
                return 2
            case .third:
                return 3
            case .fourth:
                return 4
            case .fifth:
                return 5
            case .sixth:
                return 6
            case .seventh:
                return 7
            case .eighth:
                return 8
            case .ninth:
                return 9
        }
    }
    
    var description: String {
        switch self {
            case .first:
                return "grade.first".localized
            case .second:
                return "grade.second".localized
            case .third:
                return "grade.third".localized
            case .fourth:
                return "grade.fourth".localized
            case .fifth:
                return "grade.fifth".localized
            case .sixth:
                return "grade.sixth".localized
            case .seventh:
                return "grade.seventh".localized
            case .eighth:
                return "grade.eighth".localized
            case .ninth:
                return "grade.ninth".localized
        }
    }
    
    init(rawValue: RawValue) {
        switch rawValue {
            case 1:
                self = .first
            case 2:
                self = .second
            case 3:
                self = .third
            case 4:
                self = .fourth
            case 5:
                self = .fifth
            case 6:
                self = .sixth
            case 7:
                self = .seventh
            case 8:
                self = .eighth
            case 9:
                self = .ninth
            default:
                self = .first
        }
    }
    
    init(description: String) {
        switch description {
            case "grade.first".localized:
                self = .first
            case "grade.second".localized:
                self = .second
            case "grade.third".localized:
                self = .third
            case "grade.fourth".localized:
                self = .fourth
            case "grade.fifth".localized:
                self = .fifth
            case "grade.sixth".localized:
                self = .sixth
            case "grade.seventh".localized:
                self = .seventh
            case "grade.eighth".localized:
                self = .eighth
            case "grade.ninth".localized:
                self = .ninth
            default:
                self = .first
        }
    }
    
}
