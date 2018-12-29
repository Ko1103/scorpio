//
//  Answer.swift
//  scorpio
//
//  Created by 山浦功 on 2018/12/29.
//  Copyright © 2018 com.yamaura. All rights reserved.
//

import Foundation
import Realm
import RealmSwift

class Answer: Object {
    @objc dynamic var id = ""
    @objc dynamic var userId = ""
    @objc dynamic var questionnaireId = ""
    @objc dynamic var questionId = ""
    @objc dynamic var choiceId = ""
    @objc dynamic var createdAt = Date()
    @objc dynamic var updatedAt = Date()

    override static func primaryKey() -> String? {
        return "id"
    }
}
