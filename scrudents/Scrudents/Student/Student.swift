//
//  Student.swift
//  Scrudents
//
//  Entidade que representa um Estudante com informações necessárias
//  para a sua inscrição em alguma Instituição de Ensino.
//
//  Created by Wellington Nascente Hirsch on 16/10/20.
//

import Foundation
import RealmSwift

class Student: Object, Entity {
    
    @objc dynamic var id: String = UUID().uuidString
    @objc dynamic var createdAt: Date = Date()
    @objc dynamic var modifiedAt: Date = Date()
    
    // Nome Completo validado pela função String.isValidName()
    @objc dynamic var name: String = String()
    // Data de Nascimento validado pela função Date.isValidBirthday()
    @objc dynamic var birthdate: Date = Date()
    // Série de Ingresso
    @objc dynamic var grade: Int = Int()
    // Endereço do Estudante
    @objc dynamic var address: Address? = Address()
    // Informações sobre a Mãe do Estudante
    @objc dynamic var mother: Mother? = Mother()
    
    override static func primaryKey() -> String? {
        return "id"
    }
    
    convenience init(copying student: Student) {
        self.init()
        self.id = student.id
        self.createdAt = student.createdAt
        self.modifiedAt = student.modifiedAt
        self.name = student.name
        self.birthdate = student.birthdate
        self.grade = student.grade
        self.address = student.address
        self.mother = student.mother
    }
    
    convenience init(name: String, birthdate: Date, grade: Int, address: Address, mother: Mother) {
        self.init()
        self.name = name
        self.birthdate = birthdate
        self.grade = grade
        self.address = Address(copying: address)
        self.mother = Mother(copying: mother)
    }
    
}
