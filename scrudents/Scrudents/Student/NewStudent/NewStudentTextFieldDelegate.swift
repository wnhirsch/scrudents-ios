//
//  NewStudentTextFieldDelegate.swift
//  Scrudents
//
//  Created by Wellington Nascente Hirsch on 17/10/20.
//

import Foundation
import UIKit

extension NewStudentViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        switch textField {
            case studentNameField:
                studentNameField.resignFirstResponder()
                studentBirthdateField.becomeFirstResponder()
            case studentBirthdateField:
                studentBirthdateField.resignFirstResponder()
                studentGradeField.becomeFirstResponder()
            case studentGradeField:
                studentGradeField.resignFirstResponder()
                addressCEPField.becomeFirstResponder()
            case addressCEPField:
                addressCEPField.resignFirstResponder()
                addressStreetField.becomeFirstResponder()
            case addressStreetField:
                addressStreetField.resignFirstResponder()
                addressNumberField.becomeFirstResponder()
            case addressNumberField:
                addressNumberField.resignFirstResponder()
                addressAddonField.becomeFirstResponder()
            case addressAddonField:
                addressAddonField.resignFirstResponder()
                addressDistrictField.becomeFirstResponder()
            case addressDistrictField:
                addressDistrictField.resignFirstResponder()
                addressCityField.becomeFirstResponder()
            case addressCityField:
                addressCityField.resignFirstResponder()
                addressStateField.becomeFirstResponder()
            case addressStateField:
                addressStateField.resignFirstResponder()
                motherNameField.becomeFirstResponder()
            case motherNameField:
                motherNameField.resignFirstResponder()
                motherCPFField.becomeFirstResponder()
            case motherCPFField:
                motherCPFField.resignFirstResponder()
                addressPaydayField.becomeFirstResponder()
            case addressPaydayField:
                addressPaydayField.resignFirstResponder()
            default:
                break
        }
        
        return true
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        textField.setErrorState(hasError: false)
        self.activeTextField = textField
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        switch textField {
            case studentNameField:
                if let name = studentNameField.text, name.isValidName() {
                    self.name = name
                }
                else {
                    studentNameField.setErrorState(hasError: true)
                }
            case studentGradeField:
                print("Show picker")
            case addressCEPField:
                if let cep = addressCEPField.text, cep.isValidCEP() {
                    self.address.cep = cep
                }
                else {
                    addressCEPField.setErrorState(hasError: true)
                }
            case addressStreetField:
                if let street = addressStreetField.text, street.isValidStreet() {
                    self.address.street = street
                }
                else {
                    addressStreetField.setErrorState(hasError: true)
                }
            case addressNumberField:
                if let numberStr = addressNumberField.text, let number = Int(numberStr), number > 0 {
                    self.address.number = number
                }
                else {
                    addressNumberField.setErrorState(hasError: true)
                }
            case addressAddonField:
                if let addon = addressAddonField.text, addon.isValidAddon() {
                    self.address.addon = addon
                }
                else {
                    addressAddonField.setErrorState(hasError: true)
                }
            case addressDistrictField:
                if let district = addressDistrictField.text, district.isValidDistrict() {
                    self.address.district = district
                }
                else {
                    addressDistrictField.setErrorState(hasError: true)
                }
            case addressCityField:
                if let city = addressCityField.text, city.isValidCity() {
                    self.address.city = city
                }
                else {
                    addressCityField.setErrorState(hasError: true)
                }
            case addressStateField:
                if let state = addressStateField.text, state.isValidState() {
                    self.address.state = state
                }
                else {
                    addressStateField.setErrorState(hasError: true)
                }
            case motherNameField:
                if let name = motherNameField.text, name.isValidName() {
                    self.mother.name = name
                }
                else {
                    motherNameField.setErrorState(hasError: true)
                }
            case motherCPFField:
                if let cpf = motherCPFField.text, cpf.isValidCPF() {
                    self.mother.cpf = cpf
                }
                else {
                    motherCPFField.setErrorState(hasError: true)
                }
            default:
                break
        }
    }
    
}
