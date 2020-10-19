//
//  MainDatePickerHelper.swift
//  Scrudents
//
//  Created by Wellington Nascente Hirsch on 18/10/20.
//

import Foundation
import UIKit

extension MainViewController {
    
    func setupMinBirthdatePicker() {
        let datePicker = UIDatePicker()
        datePicker.datePickerMode = .date
        datePicker.setDate(self.minBirthdate, animated: true)
        datePicker.maximumDate = Date() - Date.Year * Double(Constants.Validations.minimumAge)
        datePicker.addTarget(self, action: #selector(minBirthdatePickerDidChangeValue), for: .valueChanged)
        
        minBirthdateField.inputView = datePicker
    }
    
    @objc func minBirthdatePickerDidChangeValue(_ datePicker: UIDatePicker) {
        self.minBirthdate = datePicker.date
        minBirthdateField.text = "day.month.year".localized(datePicker.date.day, datePicker.date.month, datePicker.date.year)
    }
    
    func setupMaxBirthdatePicker() {
        let datePicker = UIDatePicker()
        datePicker.datePickerMode = .date
        datePicker.setDate(self.maxBirthdate, animated: true)
        datePicker.maximumDate = Date() - Date.Year * Double(Constants.Validations.minimumAge)
        datePicker.addTarget(self, action: #selector(maxBirthdatePickerDidChangeValue), for: .valueChanged)
        
        maxBirthdateField.inputView = datePicker
    }
    
    @objc func maxBirthdatePickerDidChangeValue(_ datePicker: UIDatePicker) {
        self.maxBirthdate = datePicker.date
        maxBirthdateField.text = "day.month.year".localized(datePicker.date.day, datePicker.date.month, datePicker.date.year)
    }
    
}
