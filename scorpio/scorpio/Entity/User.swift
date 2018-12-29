//
//  User.swift
//  scorpio
//
//  Created by 山浦功 on 2018/12/29.
//  Copyright © 2018 com.yamaura. All rights reserved.
//

import Foundation
import Realm
import RealmSwift

class User: Object {
    @objc dynamic var id = ""
    @objc dynamic var name = ""
    @objc dynamic var createdAt = Date()
    @objc dynamic var updatedAt = Date()

    override static func primaryKey() -> String? {
        return "id"
    }
}
