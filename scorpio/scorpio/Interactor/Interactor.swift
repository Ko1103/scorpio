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

private protocol InteractorInterface {
    static func update<T: Object>(object: T)
    static func update<T: Object>(objects: [T])
    static func delete<T: Object>(object: T)
    static func delete<T: Object>(objects: [T])
}

class Interactor: InteractorInterface {

    class func update<T: Object>(object: T) {
        let realm = try! Realm()
        try! realm.write {
            realm.add(object, update: true)
        }
    }

    class func update<T: Object>(objects: [T]) {
        let realm = try! Realm()
        try! realm.write {
            objects.forEach({ realm.add($0, update: true) })
        }
    }

    class func delete<T: Object>(object: T) {
        let realm = try! Realm()
        try! realm.write {
            realm.delete(object)
        }
    }

    class func delete<T: Object>(objects: [T]) {
        let realm = try! Realm()
        try! realm.write {
            objects.forEach({ realm.add($0, update: true) })
        }
    }

    class func get<T: Object>(object: T.Type, primarykey: String) -> T? {
        let realm = try! Realm()
        return realm.object(ofType: T.self, forPrimaryKey: primarykey)
    }
}

extension Interactor where T:Questionnaire {
    class func getAll<T:Object>()  -> [T] {
        let realm = try! Realm()
        let items = realm.objects(T.self)
        return Array(items)
    }
}
