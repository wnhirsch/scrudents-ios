//
//  Student.swift
//  Scrudents
//
//  Entidade que represnta um Estudante com informações necessárias
//  para a sua inscrição em alguma Instituição de Ensino.
//
//  Created by Wellington Nascente Hirsch on 16/10/20.
//
//

import Foundation
import RealmSwift

class Student: Entity {
    
    // Nome Completo validado pela função String.isValidName()
    @objc dynamic var name: String = String()
    // Data de Nascimento validado pela função Date.isValidBirthday()
    @objc dynamic var birthDate: Date = Date()
    // Série de Ingresso validado pela função Int.isValidGrade()
    @objc dynamic var grade: Int = Int()
    // Endereço do Estudante
    @objc dynamic var address: Address = Address()
    // Informações sobre a Mãe do Estudante
    @objc dynamic var mother: Mother = Mother()
    
    convenience init(copying student: Student) {
        self.init()
        self.name = student.name
        self.birthDate = student.birthDate
        self.grade = student.grade
        self.address = Address(copying: student.address)
        self.mother = Mother(copying: student.mother)
    }
    
    convenience init(name: String, birthDate: Date, grade: Int, address: Address, mother: Mother) {
        self.init()
        self.name = name
        self.birthDate = birthDate
        self.grade = grade
        self.address = Address(copying: address)
        self.mother = Mother(copying: mother)
    }
    
    override static func ignoredProperties() -> [String] {
        return []
    }
    
}
