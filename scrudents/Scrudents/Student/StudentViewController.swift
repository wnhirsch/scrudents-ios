//
//  StudentViewController.swift
//  Scrudents
//
//  Created by Wellington Nascente Hirsch on 18/10/20.
//

import Foundation
import UIKit

extension Notification.Name {
    static let studentChanged = Notification.Name("student-changed")
}
class StudentViewController: UIViewController {
    
    // MARK: - Storyboard Outlets
    @IBOutlet weak var backButton: UIBarButtonItem!
    @IBOutlet weak var editButton: UIBarButtonItem!
    @IBOutlet weak var removeButton: UIBarButtonItem!
    
    @IBOutlet weak var studentNameLabel: UILabel!
    @IBOutlet weak var studentBirthdayLabel: UILabel!
    @IBOutlet weak var studentGradeLabel: UILabel!
    @IBOutlet weak var addressCEPLabel: UILabel!
    @IBOutlet weak var addressStreetLabel: UILabel!
    @IBOutlet weak var addressAddonLabel: UILabel!
    @IBOutlet weak var addressDistrictLabel: UILabel!
    @IBOutlet weak var addressCityLabel: UILabel!
    @IBOutlet weak var motherNameLabel: UILabel!
    @IBOutlet weak var motherCPFLabel: UILabel!
    @IBOutlet weak var motherPaydayLabel: UILabel!

    // MARK: - Variables
    var student: Student?
    
    // MARK: - View Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let student = self.student {
            studentNameLabel.text = student.name
            studentNameLabel.font = UIFont.systemFont(ofSize: studentNameLabel.font.pointSize)
            
            studentBirthdayLabel.text = "day.month.year".localized(student.birthdate.day, student.birthdate.month, student.birthdate.year)
            studentBirthdayLabel.font = UIFont.systemFont(ofSize: studentBirthdayLabel.font.pointSize)
            
            studentGradeLabel.text = Grade(rawValue: student.grade).description
            studentGradeLabel.font = UIFont.systemFont(ofSize: studentGradeLabel.font.pointSize)
            
            if let address = student.address {
                addressCEPLabel.text = address.cep
                addressCEPLabel.font = UIFont.systemFont(ofSize: addressCEPLabel.font.pointSize)
                
                addressStreetLabel.text = "street.number".localized(address.street, address.number)
                addressStreetLabel.font = UIFont.systemFont(ofSize: addressStreetLabel.font.pointSize)
                
                addressAddonLabel.text = address.addon
                addressAddonLabel.font = UIFont.systemFont(ofSize: addressAddonLabel.font.pointSize)
                
                addressDistrictLabel.text = address.district
                addressDistrictLabel.font = UIFont.systemFont(ofSize: addressDistrictLabel.font.pointSize)
                
                addressCityLabel.text = "city.state".localized(address.city, address.state)
                addressCityLabel.font = UIFont.systemFont(ofSize: addressCityLabel.font.pointSize)
            }
            if let mother = student.mother {
                motherNameLabel.text = mother.name
                motherNameLabel.font = UIFont.systemFont(ofSize: motherNameLabel.font.pointSize)
                
                motherCPFLabel.text = mother.cpf
                motherCPFLabel.font = UIFont.systemFont(ofSize: motherCPFLabel.font.pointSize)
                
                motherPaydayLabel.text = "day.month.year".localized(mother.payday.day, mother.payday.month, mother.payday.year)
                motherPaydayLabel.font = UIFont.systemFont(ofSize: motherPaydayLabel.font.pointSize)
            }
        }
        
    }
    
    // MARK: - Storyboard Actions
    @IBAction func back(_ sender: Any) {
        NotificationCenter.default.post(name: .refreshMainTable, object: nil)
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func edit(_ sender: Any) {
        let newStudenStoryboard = UIStoryboard(name: "NewStudent", bundle: nil)
        let newStudentViewController = newStudenStoryboard.instantiateViewController(withIdentifier: "NewStudentViewController") as! NewStudentViewController
        let newStudentNavigationController = UINavigationController(rootViewController: newStudentViewController)
        
        newStudentViewController.student = self.student
        newStudentViewController.isEditingStudent = true
        
        NotificationCenter.default.addObserver(self, selector: #selector(studentChanged), name: .studentChanged, object: nil)
        self.present(newStudentNavigationController, animated: true, completion: nil)
    }
    
    @IBAction func remove(_ sender: Any) {
        if let student = self.student {
            StudentFacade.shared.deleteEntity(withIdentifier: student.id)
        }
        self.dismiss(animated: true, completion: nil)
    }
    
    // MARK: - Notifications
    @objc private func studentChanged(notification: NSNotification) {
        NotificationCenter.default.removeObserver(self, name: .studentChanged, object: nil)
        
        if let student = notification.userInfo?["student"] as? Student {
            self.student = student
            
            studentNameLabel.text = student.name
            studentNameLabel.font = UIFont.systemFont(ofSize: studentNameLabel.font.pointSize)
            
            studentBirthdayLabel.text = "day.month.year".localized(student.birthdate.day, student.birthdate.month, student.birthdate.year)
            studentBirthdayLabel.font = UIFont.systemFont(ofSize: studentBirthdayLabel.font.pointSize)
            
            studentGradeLabel.text = Grade(rawValue: student.grade).description
            studentGradeLabel.font = UIFont.systemFont(ofSize: studentGradeLabel.font.pointSize)
            
            if let address = student.address {
                addressCEPLabel.text = address.cep
                addressCEPLabel.font = UIFont.systemFont(ofSize: addressCEPLabel.font.pointSize)
                
                addressStreetLabel.text = "street.number".localized(address.street, address.number)
                addressStreetLabel.font = UIFont.systemFont(ofSize: addressStreetLabel.font.pointSize)
                
                addressAddonLabel.text = address.addon
                addressAddonLabel.font = UIFont.systemFont(ofSize: addressAddonLabel.font.pointSize)
                
                addressDistrictLabel.text = address.district
                addressDistrictLabel.font = UIFont.systemFont(ofSize: addressDistrictLabel.font.pointSize)
                
                addressCityLabel.text = "city.state".localized(address.city, address.state)
                addressCityLabel.font = UIFont.systemFont(ofSize: addressCityLabel.font.pointSize)
            }
            if let mother = student.mother {
                motherNameLabel.text = mother.name
                motherNameLabel.font = UIFont.systemFont(ofSize: motherNameLabel.font.pointSize)
                
                motherCPFLabel.text = mother.cpf
                motherCPFLabel.font = UIFont.systemFont(ofSize: motherCPFLabel.font.pointSize)
                
                motherPaydayLabel.text = "day.month.year".localized(mother.payday.day, mother.payday.month, mother.payday.year)
                motherPaydayLabel.font = UIFont.systemFont(ofSize: motherPaydayLabel.font.pointSize)
            }
        }
    }
    
}
