//
//  EntityFacade.swift
//  Scrudents
//
//  Created by Wellington Nascente Hirsch on 17/10/20.
//

import Foundation
import RealmSwift

class Facade<T: Object> where T: Entity {
    
    func insert(_ entity: T) {
        guard let realm = try? Realm() else {
            return
        }
        
        try! realm.write {
            realm.add(entity, update: .all)
        }
    }
    
    func insert(_ entities: [T]) {
        guard let realm = try? Realm() else {
            return
        }
        
        try! realm.write {
            realm.add(entities, update: .all)
        }
    }
    
    func update(_ entity: T) {
        guard let realm = try? Realm() else {
            return
        }
        
        try! realm.write {
            realm.add(entity, update: .modified)
            realm.create(T.self, value: ["id": entity.id,
                                         "modifiedAt": Date()], update: .modified)
        }
    }

    func deleteEntity(withIdentifier id: String) {
        guard let realm = try? Realm() else {
            return
        }
        
        if let entity = realm.object(ofType: T.self, forPrimaryKey: id as AnyObject) {
            try! realm.write {
                realm.delete(entity)
            }
        }
    }
    
    func findAll() -> Results<T>? {
        guard let realm = try? Realm() else {
            return nil
        }

        return realm.objects(T.self)
    }

    func getLastUpdated() -> T? {
        guard let realm = try? Realm() else {
            return nil
        }
        
        return realm.objects(T.self).sorted(byKeyPath: "modifiedAt", ascending: false).first
    }
    
    func find(withPredicate predicate: NSPredicate) -> Results<T>? {
        return findAll()?.filter(predicate)
    }

    func findByID(id: String) -> Results<T>? {
        return find(withPredicate: NSPredicate(format: "id = %@", id))
    }
    
}
