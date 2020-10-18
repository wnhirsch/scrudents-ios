//
//  NewStudentPickerViewDelegate.swift
//  Scrudents
//
//  Created by Wellington Nascente Hirsch on 17/10/20.
//

import Foundation
import UIKit

extension NewStudentViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    
    func setupGradePickerView() {
        self.gradePickerView.delegate = self
        self.studentGradeField.inputView = self.gradePickerView
        self.studentGradeField.text = self.gradeDataSource[0].description
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return self.gradeDataSource.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return self.gradeDataSource[row].description
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        self.studentGradeField.text = self.gradeDataSource[row].description
        self.grade = self.gradeDataSource[row]
    }
    
    
}
