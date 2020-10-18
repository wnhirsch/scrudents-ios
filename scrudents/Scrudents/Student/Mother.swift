//
//  Mother.swift
//  Scrudents
//
//  Entidade auxiliar (sem ID) para complementar outros Objetos Realm.
//  Armazena informações importantes sobre a Mãe de um Estudante.
//
//  Created by Wellington Nascente Hirsch on 16/10/20.
//

import Foundation
import RealmSwift

class Mother: Object {
    
    // Nome Completo validado pela função String.isValidName()
    @objc dynamic var name: String = String()
    // CPF validado pela função String.isValidCPF()
    @objc dynamic var cpf: String = String()
    // Nome Completo validado pela função Date.isValidPayday()
    @objc dynamic var payday: Date = Date()
    
    convenience init(copying mother: Mother) {
        self.init()
        self.name = mother.name
        self.cpf = mother.cpf
        self.payday = mother.payday
    }
    
    convenience init(name: String, cpf: String, payday: Date) {
        self.init()
        self.name = name
        self.cpf = cpf
        self.payday = payday
    }
    
}
