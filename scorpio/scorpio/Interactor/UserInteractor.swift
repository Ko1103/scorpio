//
//  UserInteractor.swift
//  scorpio
//
//  Created by 山浦功 on 2018/12/29.
//  Copyright © 2018 com.yamaura. All rights reserved.
//

import Foundation
import Realm
import RealmSwift

protocol UserInteractorInterface: class {
    func getUser(id: String) -> User?
    func getUsers() -> [User]
}

final class UserInteractor: Interactor, UserInteractorInterface {
    func getUser(id: String) -> User? {
        let realm = try! Realm()
        return realm.object(ofType: User.self, forPrimaryKey: id)
    }

    func getUsers() -> [User] {
        let realm = try! Realm()
        return Array(realm.objects(User.self))
    }
}
