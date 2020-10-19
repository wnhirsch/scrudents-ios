//
//  MainPickerViewDelegate.swift
//  Scrudents
//
//  Created by Wellington Nascente Hirsch on 18/10/20.
//

import Foundation
import UIKit

extension MainViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    
    func setupGradePickerView() {
        self.gradePickerView.delegate = self
        self.gradeField.inputView = self.gradePickerView
        self.gradeField.text = self.gradeDataSource[0].description
    }
    
    func setupSearchTopicPickerView() {
        self.searchTopicPickerView.delegate = self
        self.searchTopicField.inputView = self.searchTopicPickerView
        self.searchTopicField.text = self.searchTopicDataSource[0].description
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        switch pickerView {
            case gradePickerView:
                return self.gradeDataSource.count
            case searchTopicPickerView:
                return self.searchTopicDataSource.count
            default:
                break
        }
        
        return 0
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        switch pickerView {
            case gradePickerView:
                return self.gradeDataSource[row].description
            case searchTopicPickerView:
                return self.searchTopicDataSource[row].description
            default:
                break
        }
        
        return nil
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        switch pickerView {
            case gradePickerView:
                self.gradeField.text = self.gradeDataSource[row].description
                self.grade = self.gradeDataSource[row]
            case searchTopicPickerView:
                self.searchTopicField.text = self.searchTopicDataSource[row].description
                self.searchTopic = self.searchTopicDataSource[row]
            default:
                break
        }
    }
    
}
