//
//  Enums.swift
//  Scrudents
//
//  Created by Wellington Nascente Hirsch on 17/10/20.
//

import Foundation

@objc enum Grade: Int, RawRepresentable, CustomStringConvertible, CaseIterable {
    
    typealias RawValue = Int
    
    case none
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
            case .none:
                return 0
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
            case .none:
                return "grade.none".localized
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
            case 0:
                self = .none
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
            case "grade.none".localized:
                self = .none
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

@objc enum SearchTopic: Int, RawRepresentable, CustomStringConvertible, CaseIterable {
    
    typealias RawValue = Int
    
    case studentName
    case addressStreet
    case addressDistrict
    case addressCity
    case addressState
    case motherName
    
    var rawValue: Int {
        switch self {
            case .studentName:
                return 0
            case .addressStreet:
                return 1
            case .addressDistrict:
                return 2
            case .addressCity:
                return 3
            case .addressState:
                return 4
            case .motherName:
                return 5
        }
    }
    
    var description: String {
        switch self {
            case .studentName:
                return "filter.student.name".localized
            case .addressStreet:
                return "filter.address.street".localized
            case .addressDistrict:
                return "filter.address.district".localized
            case .addressCity:
                return "filter.address.city".localized
            case .addressState:
                return "filter.address.state".localized
            case .motherName:
                return "filter.mother.name".localized
        }
    }
    
    init(rawValue: RawValue) {
        switch rawValue {
            case 0:
                self = .studentName
            case 1:
                self = .addressStreet
            case 2:
                self = .addressDistrict
            case 3:
                self = .addressCity
            case 4:
                self = .addressState
            case 5:
                self = .motherName
            default:
                self = .studentName
        }
    }
    
    init(description: String) {
        switch description {
            case "filter.student.name".localized:
                self = .studentName
            case "filter.address.street".localized:
                self = .addressStreet
            case "filter.address.district".localized:
                self = .addressDistrict
            case "filter.address.city".localized:
                self = .addressCity
            case "filter.address.state".localized:
                self = .addressState
            case "filter.mother.name".localized:
                self = .motherName
            default:
                self = .studentName
        }
    }
    
}
