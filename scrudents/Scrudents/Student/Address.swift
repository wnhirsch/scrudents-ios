//
//  Address.swift
//  Scrudents
//
//  Entidade auxiliar (sem ID) para complementar outros Objetos Realm.
//  Armazena as informações necessárias para representar um endereço.
//
//  Created by Wellington Nascente Hirsch on 16/10/20.
//
//

import Foundation
import RealmSwift

class Address: Object {
    
    // CEP validado pela função String.isValidCEP()
    @objc dynamic var cep: String = String()
    // Rua validado pela função String.isValidStreet()
    @objc dynamic var street: Int = Int()
    // Número da casa
    @objc dynamic var number: String = String()
    // Complemento do endereço validado pela função String.isValidAddon()
    @objc dynamic var addon: String = String()
    // Bairro validado pela função String.isValidDistrict()
    @objc dynamic var district: String = String()
    // Cidade validado pela função String.isValidCity()
    @objc dynamic var city: String = String()
    // Estado validado pela função String.isValidState()
    @objc dynamic var state: String = String()
    
    convenience init(copying address: Address) {
        self.init()
        self.cep = address.cep
        self.street = address.street
        self.addon = address.addon
        self.district = address.district
        self.city = address.city
        self.state = address.state
    }
    
}
