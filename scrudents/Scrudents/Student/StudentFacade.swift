//
//  StudentFacade.swift
//  Scrudents
//
//  Created by Wellington Nascente Hirsch on 17/10/20.
//

import Foundation
import RealmSwift
import Realm

class StudentFacade: Facade<Student> {
    
    static let shared = StudentFacade()
    
    let synchronizing: DispatchSemaphore
    let syncQueue = DispatchQueue.global(qos: DispatchQoS.QoSClass.utility)
    
    fileprivate override init() {
        self.synchronizing = DispatchSemaphore(value: 1)
        super.init()
    }
    
}
