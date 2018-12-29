//
//  Interactor.swift
//  scorpio
//
//  Created by 山浦功 on 2018/12/29.
//  Copyright © 2018 com.yamaura. All rights reserved.
//

import Foundation
import Realm
import RealmSwift

protocol InteractorInterface {
    static func update<T: Object>(object: T)
    static func delete<T: Object>(object: T)
}

class Interactor: InteractorInterface {

    class func update<T: Object>(object: T) {
        let realm = try! Realm()
        try! realm.write {
            realm.add(object, update: true)
        }
    }

    class func delete<T: Object>(object: T) {
        let realm = try! Realm()
        try! realm.write {
            realm.delete(object)
        }
    }
}
