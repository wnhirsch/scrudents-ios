//
//  NewStudentDatePickerHelper.swift
//  Scrudents
//
//  Created by Wellington Nascente Hirsch on 17/10/20.
//

import Foundation
import UIKit

extension NewStudentViewController {
    
    func setupBirthdatePicker() {
        let datePicker = UIDatePicker()
        datePicker.datePickerMode = .date
        datePicker.setDate(self.birthdate, animated: true)
        datePicker.maximumDate = Date() - Date.Year * Double(Constants.Validations.minimumAge)
        datePicker.addTarget(self, action: #selector(birthdatePickerDidChangeValue), for: .valueChanged)
        
        studentBirthdateField.inputView = datePicker
    }
    
    @objc func birthdatePickerDidChangeValue(_ datePicker: UIDatePicker) {
        self.birthdate = datePicker.date
        studentBirthdateField.text = "day.month.year".localized(datePicker.date.day, datePicker.date.month, datePicker.date.year)
    }
    
    func setupPaydayPicker() {
        let datePicker = UIDatePicker()
        datePicker.datePickerMode = .date
        datePicker.setDate(self.mother.payday, animated: true)
        datePicker.minimumDate = Date() + Date.Day
        datePicker.addTarget(self, action: #selector(paydayPickerDidChangeValue), for: .valueChanged)
        
        addressPaydayField.inputView = datePicker
    }
    
    @objc func paydayPickerDidChangeValue(_ datePicker: UIDatePicker) {
        self.mother.payday = datePicker.date
        addressPaydayField.text = "day.month.year".localized(datePicker.date.day, datePicker.date.month, datePicker.date.year)
    }
    
}
