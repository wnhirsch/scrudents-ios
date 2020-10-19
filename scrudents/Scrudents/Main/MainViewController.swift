//
//  MainViewController.swift
//  Scrudents
//
//  Created by Wellington Nascente Hirsch on 14/10/20.
//

import Foundation
import UIKit

extension Notification.Name {
    static let refreshMainTable = Notification.Name("refresh-main-table")
}
class MainViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate, UITextFieldDelegate {

    // MARK: - Storyboard Outlets
    @IBOutlet weak var mainTableView: UITableView!
    @IBOutlet weak var newStudentButton: UIBarButtonItem!
    
    @IBOutlet weak var textSearchBar: UISearchBar!
    @IBOutlet weak var resetFilterButton: UIButton!
    @IBOutlet weak var applyFilterButton: UIButton!
    
    @IBOutlet weak var searchTopicField: UITextField!
    @IBOutlet weak var minBirthdateField: UITextField!
    @IBOutlet weak var maxBirthdateField: UITextField!
    @IBOutlet weak var gradeField: UITextField!
    
    var activeTextField: UITextField = UITextField()
    var searchTopicPickerView = UIPickerView()
    var gradePickerView = UIPickerView()
    
    // MARK: - Variables
    var studentList: [Student] = []
    
    var searchTopic: SearchTopic = SearchTopic.studentName
    var minBirthdate: Date = Date()
    var maxBirthdate: Date = Date()
    var grade: Grade = Grade.none
    
    var searchTopicDataSource = SearchTopic.allCases
    var gradeDataSource = Grade.allCases
    
    var showFilterConstraint: NSLayoutConstraint? = nil
    
    // MARK: - View Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Show/Hide filter view
        self.showFilterConstraint = self.view.constraints.first(where: { $0.identifier == "showFilterConstraint" } )
        
        mainTableView.delegate = self
        mainTableView.dataSource = self
        
        textSearchBar.delegate = self
        textSearchBar.endEditing(true)
        
        searchTopicField.delegate = self
        minBirthdateField.delegate = self
        maxBirthdateField.delegate = self
        gradeField.delegate = self
        
        self.setupFilters()
        self.setupSearchTopicPickerView()
        self.setupMinBirthdatePicker()
        self.setupMaxBirthdatePicker()
        self.setupGradePickerView()
        self.addDoneButtonOnKeyboard()
        self.hideKeyboardWhenTappedAround()
        
        NotificationCenter.default.addObserver(self, selector: #selector(refreshMainTable), name: .refreshMainTable, object: nil)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        fetchStudents()
        mainTableView.reloadData()
    }
    
    // MARK: - Storyboard Actions
    @IBAction func newStudent(_ sender: Any) {
        let newStudentStoryboard = UIStoryboard(name: "NewStudent", bundle: nil)
        let newStudentViewController = newStudentStoryboard.instantiateViewController(withIdentifier: "NewStudentViewController") as! NewStudentViewController
        let newStudentNavigationController = UINavigationController(rootViewController: newStudentViewController)
        
        self.present(newStudentNavigationController, animated: true, completion: nil)
    }
    
    @IBAction func resetFilter(_ sender: Any) {
        setupFilters()
        fetchStudents()
        mainTableView.reloadData()
    }
    
    @IBAction func applyFilter(_ sender: Any) {
        fetchStudents()
        mainTableView.reloadData()
    }
    
    // MARK: - Layout Helper
    func setupFilters() {
        self.textSearchBar.text = nil
        self.searchTopic = SearchTopic.studentName
        self.minBirthdate = Date(timeIntervalSince1970: Double.zero)
        self.maxBirthdate = Date() - Date.Year * Double(Constants.Validations.minimumAge)
        self.grade = Grade.none
        
        searchTopicField.text = self.searchTopic.description
        minBirthdateField.text = "day.month.year".localized(self.minBirthdate.day, self.minBirthdate.month, self.minBirthdate.year)
        maxBirthdateField.text = "day.month.year".localized(self.maxBirthdate.day, self.maxBirthdate.month, self.maxBirthdate.year)
        gradeField.text = self.grade.description
    }
    
    func addDoneButtonOnKeyboard() {
        let keyboardToolbar: UIToolbar = UIToolbar(frame: CGRect(x: 0, y: 0, width: self.view.frame.width, height: 50))
        keyboardToolbar.barStyle = UIBarStyle.default
        
        let flexSpace = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace,
                                        target: nil, action: nil)
        let done: UIBarButtonItem = UIBarButtonItem(title: "done".localized, style: UIBarButtonItem.Style.done,
                                                    target: self, action: #selector(resignTextField))

        var items: [UIBarButtonItem] = []
        items.append(flexSpace)
        items.append(done)

        keyboardToolbar.items = items
        keyboardToolbar.sizeToFit()
        
        searchTopicField.inputAccessoryView = keyboardToolbar
        minBirthdateField.inputAccessoryView = keyboardToolbar
        maxBirthdateField.inputAccessoryView = keyboardToolbar
        gradeField.inputAccessoryView = keyboardToolbar
    }
    
    @objc func resignTextField() {
        self.activeTextField.resignFirstResponder()
    }
    
    // MARK: - Data Methods
    func fetchStudents() {
        guard let results = StudentFacade.shared.findAll() else {
            return
        }
        
        self.studentList = results.compactMap({
            student in
            
            if student.birthdate >= self.minBirthdate && student.birthdate <= self.maxBirthdate {
                return student
            }
            else {
                return nil
            }
        })
        
        if self.grade != Grade.none {
            self.studentList = self.studentList.compactMap({
                student in
                
                if student.grade == self.grade.rawValue {
                    return student
                }
                else {
                    return nil
                }
            })
        }
        
        if let searchText = self.textSearchBar.text, searchText.count > 0 {
            let studentScored: [(Student, Int)] = self.studentList.compactMap({
                student in
                
                var studentText: String = String()
                switch self.searchTopic {
                    case .studentName:
                        studentText = student.name
                    case .addressStreet:
                        studentText = student.address?.street ?? String()
                    case .addressDistrict:
                        studentText = student.address?.district ?? String()
                    case .addressCity:
                        studentText = student.address?.city ?? String()
                    case .addressState:
                        studentText = student.address?.state ?? String()
                    case .motherName:
                        studentText = student.mother?.name ?? String()
                }
                
                if studentText.count > 0 {
                    let score = self.scoreSentences(base: searchText, search: studentText)
                    if score > 0 {
                        return (student, score)
                    }
                }
                
                return nil
            })
            self.studentList = studentScored.sorted {
                $0.1 > $1.1
            }.map( { $0.0 })
        }
        else {
            self.studentList = self.studentList.sorted {
                $0.modifiedAt > $1.modifiedAt
            }
        }
    }
    
    
    func scoreSentences(base: String, search: String) -> Int {
        let baseWords = base.split{ $0 == " " }.map(String.init)
        let searchWords = search.split{ $0 == " " }.map(String.init)
        var score: Int = Int.zero
        
        for searchWord in searchWords {
            let searchLower = searchWord.lowercased().folding(options: .diacriticInsensitive, locale: .current)
            for baseWord in baseWords {
                let baseLower = baseWord.lowercased().folding(options: .diacriticInsensitive, locale: .current)
                if searchLower.contains(baseLower) {
                    score += 1
                }
            }
        }
        
        return score
    }
    
    // MARK: - SearchBar Delegate
    func searchBarBookmarkButtonClicked(_ searchBar: UISearchBar) {
        if let showFilterConstraint = self.showFilterConstraint {
            if showFilterConstraint.constant < 0 {
                let newConstraint = showFilterConstraint
                newConstraint.constant = 208
                self.view.removeConstraint(showFilterConstraint)
                self.view.addConstraint(newConstraint)
                self.showFilterConstraint = newConstraint
            }
            else {
                let newConstraint = showFilterConstraint
                newConstraint.constant = -8
                self.view.removeConstraint(showFilterConstraint)
                self.view.addConstraint(newConstraint)
                self.showFilterConstraint = newConstraint
            }
            
            UIView.animate(withDuration: 0.3) {
                self.view.layoutIfNeeded()
            }
        }
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        textSearchBar.resignFirstResponder()
        fetchStudents()
        mainTableView.reloadData()
    }
    
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        fetchStudents()
        mainTableView.reloadData()
    }
    
    // MARK: - TableView Delegate
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return studentList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: StudentCell = tableView.dequeueReusableCell(withIdentifier: "Main:StudentCell", for: indexPath) as! StudentCell
        
        let student = self.studentList[indexPath.row]
        cell.studentName.text = student.name
        
        let createdAt = "student.createdAt".localized("day.month.year".localized(student.birthdate.day,
                                                                                         student.birthdate.month,
                                                                                         student.birthdate.year))
        switch self.searchTopic {
            case .studentName:
                cell.studentInfo.text = createdAt
            case .addressStreet:
                cell.studentInfo.text = student.address?.street ?? createdAt
            case .addressDistrict:
                cell.studentInfo.text = student.address?.district ?? createdAt
            case .addressCity:
                cell.studentInfo.text = student.address?.city ?? createdAt
            case .addressState:
                cell.studentInfo.text = student.address?.state ?? createdAt
            case .motherName:
                cell.studentInfo.text = student.mother?.name ?? createdAt
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let studentStoryboard = UIStoryboard(name: "Student", bundle: nil)
        let studentViewController = studentStoryboard.instantiateViewController(withIdentifier: "StudentViewController") as! StudentViewController
        studentViewController.student = self.studentList[indexPath.row]
        
        let studentNavigationController = UINavigationController(rootViewController: studentViewController)
        studentNavigationController.modalPresentationStyle = .fullScreen
        
        self.present(studentNavigationController, animated: true, completion: nil)
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    // MARK: - TextField Delegate
    func textFieldDidBeginEditing(_ textField: UITextField) {
        self.activeTextField = textField
    }
    
    // MARK: - Notifications
    @objc private func refreshMainTable(notification: NSNotification) {
        fetchStudents()
        mainTableView.reloadData()
    }

}

