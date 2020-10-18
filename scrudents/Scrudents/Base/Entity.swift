//
//  Entity.swift
//  Scrudents
//
// Protocolo para definir as propriedades básicas de todas
// as entidades a serem persistidas.
//
//  Created by Wellington Nascente Hirsch on 17/10/20.
//

import Foundation

protocol Entity {
    
    var id: String { get set }
    var createdAt: Date { get set }
    var modifiedAt: Date { get set }
        
}
