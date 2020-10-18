//
//  MainViewController.swift
//  Scrudents
//
//  Created by Wellington Nascente Hirsch on 14/10/20.
//

import Foundation
import UIKit

class MainViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var mainTableView: UITableView!
    
    // MARK: - Storyboard Outlets
    @IBOutlet weak var newStudentButton: UIBarButtonItem!
    
    
    // MARK: - Variables
    var studentList: [Student] = []
    
    // MARK: - View Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        
        mainTableView.delegate = self
        mainTableView.dataSource = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        fetchStudents()
        mainTableView.reloadData()
    }
    
    // MARK: - Storyboard Actions
    @IBAction func newStudent(_ sender: Any) {
        let newStudenStoryboard = UIStoryboard(name: "NewStudent", bundle: nil)
        let newStudentViewController = newStudenStoryboard.instantiateViewController(withIdentifier: "NewStudentViewController") as! NewStudentViewController
        let newStudentNavigationController = UINavigationController(rootViewController: newStudentViewController)
        
        self.present(newStudentNavigationController, animated: true, completion: nil)
    }
    
    // MARK: - Data Methods
    func fetchStudents() {
        let results = StudentFacade.shared.findAll()
        self.studentList = results!.map{ return $0 }.sorted {
            $0.modifiedAt > $1.modifiedAt
        }
    }
    
    // MARK: - TableView Delegate
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return studentList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: StudentCell = tableView.dequeueReusableCell(withIdentifier: "Main:StudentCell", for: indexPath) as! StudentCell
        
        let student = self.studentList[indexPath.row]
        cell.studentName.text = student.name
        cell.studentInfo.text = "day.month.year".localized(student.birthdate.day, student.birthdate.month, student.birthdate.year)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("Do something")
    }

}

