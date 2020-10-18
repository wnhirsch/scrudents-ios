//
//  NewStudentViewController.swift
//  Scrudents
//
//  Created by Wellington Nascente Hirsch on 17/10/20.
//

import Foundation
import UIKit

class NewStudentViewController: UIViewController {
    
    // MARK: - Storyboard Outlets
    @IBOutlet weak var scrollView: UIScrollView!
    
    @IBOutlet weak var cancelButton: UIBarButtonItem!
    @IBOutlet weak var saveButton: UIBarButtonItem!
    
    @IBOutlet weak var studentNameField: UITextField!
    @IBOutlet weak var studentBirthdateField: UITextField!
    @IBOutlet weak var studentGradeField: UITextField!
    @IBOutlet weak var addressCEPField: UITextField!
    @IBOutlet weak var addressStreetField: UITextField!
    @IBOutlet weak var addressNumberField: UITextField!
    @IBOutlet weak var addressAddonField: UITextField!
    @IBOutlet weak var addressDistrictField: UITextField!
    @IBOutlet weak var addressCityField: UITextField!
    @IBOutlet weak var addressStateField: UITextField!
    @IBOutlet weak var motherNameField: UITextField!
    @IBOutlet weak var motherCPFField: UITextField!
    @IBOutlet weak var addressPaydayField: UITextField!
    
    var activeTextField: UITextField = UITextField()
    
    var gradePickerView = UIPickerView()
    var gradeDataSource = Grade.allCases
    
    // MARK: - Variables
    var student: Student?
    var isEditingStudent: Bool = false
    
    var name: String = String()
    var birthdate: Date = Date()
    var grade: Grade = Grade.first
    var address: Address = Address()
    var mother: Mother = Mother()
    
    // MARK: - View Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if isEditingStudent, let student = self.student, let address = student.address, let mother = student.mother {
            self.name = student.name
            self.studentNameField.text = student.name
            
            self.birthdate = student.birthdate
            self.studentBirthdateField.text = "day.month.year".localized(student.birthdate.day, student.birthdate.month, student.birthdate.year)
            
            self.grade = Grade(rawValue: student.grade)
            self.studentBirthdateField.text = student.grade.description
            
            self.address = Address(copying: address)
            self.addressCEPField.text = address.cep
            self.addressStreetField.text = address.street
            self.addressNumberField.text = String(address.number)
            self.addressAddonField.text = address.addon
            self.addressDistrictField.text = address.district
            self.addressCityField.text = address.city
            self.addressStateField.text = address.state
            
            self.mother = Mother(copying: mother)
            self.motherNameField.text = mother.name
            self.motherCPFField.text = mother.cpf
            self.addressPaydayField.text = "day.month.year".localized(mother.payday.day, mother.payday.month, mother.payday.year)
        }
        else {
            
        }
        
        self.setupTextFields()
        self.setupBirthdatePicker()
        self.setupPaydayPicker()
        self.setupGradePickerView()
        
        self.addDoneButtonOnKeyboard()
        self.hideKeyboardWhenTappedAround()
        
        NotificationCenter.default.addObserver(self, selector: #selector(handleKeyboard), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(handleKeyboard), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    // MARK: - Storyboard Actions
    @IBAction func cancel(_ sender: Any) {
        if isEditingStudent {
            // unwind
        }
        else {
            self.dismiss(animated: true, completion: nil)
        }
    }
    
    @IBAction func save(_ sender: Any) {
        self.activeTextField.resignFirstResponder()
        
        guard name.isValidName() else {
            showFieldErrorAlert(field: "student.name".localized)
            return
        }
        guard birthdate.isValidBirthday() else {
            showFieldErrorAlert(field: "student.birthdate".localized)
            return
        }
        
        guard address.cep.isValidCEP() else {
            showFieldErrorAlert(field: "address.cep".localized)
            return
        }
        guard address.street.isValidStreet() else {
            showFieldErrorAlert(field: "address.street".localized)
            return
        }
        guard address.number > 0 else {
            showFieldErrorAlert(field: "address.number".localized)
            return
        }
        guard address.addon.isValidAddon() else {
            showFieldErrorAlert(field: "address.addon".localized)
            return
        }
        guard address.district.isValidDistrict() else {
            showFieldErrorAlert(field: "address.district".localized)
            return
        }
        guard address.city.isValidCity() else {
            showFieldErrorAlert(field: "address.city".localized)
            return
        }
        guard address.state.isValidState() else {
            showFieldErrorAlert(field: "address.state".localized)
            return
        }
        
        guard mother.name.isValidName() else {
            showFieldErrorAlert(field: "mother.name".localized)
            return
        }
        guard mother.cpf.isValidCPF() else {
            showFieldErrorAlert(field: "mother.cpf".localized)
            return
        }
        guard mother.payday.isValidPayday() else {
            showFieldErrorAlert(field: "mother.payday".localized)
            return
        }
        
        if isEditingStudent, let student = self.student {
            let editStudent = Student(copying: student)
            editStudent.name = name
            editStudent.birthdate = birthdate
            editStudent.grade = grade.rawValue
            editStudent.address = address
            editStudent.mother = mother
            
            StudentFacade.shared.update(editStudent)
            // 
        }
        else {
            let newStudent = Student(name: name,
                                     birthdate: birthdate,
                                     grade: grade.rawValue,
                                     address: address,
                                     mother: mother)
            
            StudentFacade.shared.insert(newStudent)
            self.dismiss(animated: true, completion: nil)
        }
    }
    
}
