//
//  Entity.swift
//  Scrudents
//
//  Entidade Básica com informações mínimas necessárias para
//  a persistência de dados.
//
//  Created by Wellington Nascente Hirsch on 16/10/20.
//
//

import Foundation
import RealmSwift

class Entity: Object {
    
    @objc dynamic var id: String = UUID().uuidString
    @objc dynamic var createdAt: Date = Date()
    @objc dynamic var modifiedAt: Date = Date()
    
    override static func primaryKey() -> String? {
        return "id"
    }
    
}
