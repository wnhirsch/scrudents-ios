//
//  NewStudentLayoutHelper.swift
//  Scrudents
//
//  Created by Wellington Nascente Hirsch on 17/10/20.
//

import Foundation
import UIKit

extension NewStudentViewController {
    
    func showFieldErrorAlert(field: String) {
        let fieldErrorAlert = UIAlertController(title: "field.error".localized,
                                               message: "field.error.msg".localized(field),
                                               preferredStyle: .alert)
        let okay = UIAlertAction(title: "okay".localized, style: .cancel, handler: nil)
        fieldErrorAlert.addAction(okay)
        self.present(fieldErrorAlert, animated: true, completion: nil)
    }
    
    func setupTextFields() {
        studentNameField.delegate = self
        studentBirthdateField.delegate = self
        studentGradeField.delegate = self
        addressCEPField.delegate = self
        addressStreetField.delegate = self
        addressNumberField.delegate = self
        addressAddonField.delegate = self
        addressDistrictField.delegate = self
        addressCityField.delegate = self
        addressStateField.delegate = self
        motherNameField.delegate = self
        motherCPFField.delegate = self
        addressPaydayField.delegate = self
        
        studentNameField.setErrorState(hasError: false)
        studentBirthdateField.setErrorState(hasError: false)
        studentGradeField.setErrorState(hasError: false)
        addressCEPField.setErrorState(hasError: false)
        addressStreetField.setErrorState(hasError: false)
        addressNumberField.setErrorState(hasError: false)
        addressAddonField.setErrorState(hasError: false)
        addressDistrictField.setErrorState(hasError: false)
        addressCityField.setErrorState(hasError: false)
        addressStateField.setErrorState(hasError: false)
        motherNameField.setErrorState(hasError: false)
        motherCPFField.setErrorState(hasError: false)
        addressPaydayField.setErrorState(hasError: false)
        
        addressCEPField.addTarget(self, action: #selector(editingCEPChanged), for: .editingChanged)
        motherCPFField.addTarget(self, action: #selector(editingCPFChanged), for: .editingChanged)
    }
    
    func addDoneButtonOnKeyboard() {
        let keyboardToolbar: UIToolbar = UIToolbar(frame: CGRect(x: 0, y: 0, width: self.view.frame.width, height: 50))
        keyboardToolbar.barStyle = UIBarStyle.default
        
        let flexSpace = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace,
                                        target: nil, action: nil)
        let done: UIBarButtonItem = UIBarButtonItem(title: "next".localized, style: UIBarButtonItem.Style.done,
                                                    target: self, action: #selector(nextTextField))

        var items: [UIBarButtonItem] = []
        items.append(flexSpace)
        items.append(done)

        keyboardToolbar.items = items
        keyboardToolbar.sizeToFit()
        
        addressCEPField.inputAccessoryView = keyboardToolbar
        addressNumberField.inputAccessoryView = keyboardToolbar
        motherCPFField.inputAccessoryView = keyboardToolbar
        
        studentBirthdateField.inputAccessoryView = keyboardToolbar
        addressPaydayField.inputAccessoryView = keyboardToolbar
        
        studentGradeField.inputAccessoryView = keyboardToolbar
    }
    
    @objc func nextTextField() {
        self.textFieldDidEndEditing(self.activeTextField)
        _ = self.textFieldShouldReturn(self.activeTextField)
    }
    
    @objc func handleKeyboard(_ notification: Notification) {
        if let userInfo = notification.userInfo {
            let keyboardFrame = (userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue
            let textFieldFrame = activeTextField.convert(activeTextField.frame, to: scrollView)
            let scrollViewHeightWithKeyboard = scrollView.frame.height - keyboardFrame!.height
            
            if textFieldFrame.maxY > scrollViewHeightWithKeyboard {
                scrollView.setContentOffset(CGPoint(x: 0, y: textFieldFrame.maxY - scrollViewHeightWithKeyboard),
                animated: true)
            }
        }
    }
    
    @objc func editingCEPChanged() {
        if let cep = addressCEPField.text {
            addressCEPField.text = cep.applyPatternOnNumbers(pattern: Constants.Validations.CEPPattern)
        }
    }
    
    @objc func editingCPFChanged() {
        if let cpf = motherCPFField.text {
            motherCPFField.text = cpf.applyPatternOnNumbers(pattern: Constants.Validations.CPFPattern)
        }
    }
    
}
