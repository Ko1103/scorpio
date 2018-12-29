//
//  Question.swift
//  scorpio
//
//  Created by 山浦功 on 2018/12/29.
//  Copyright © 2018 com.yamaura. All rights reserved.
//
import Foundation
import Realm
import RealmSwift

class Question: Object {
    @objc dynamic var id = ""
    @objc dynamic var typeId = ""
    var choicesId = List<String>()
    @objc dynamic var required = false
    @objc dynamic var multipleAnswer = false
    @objc dynamic var createdAt = Date()
    @objc dynamic var updatedAt = Date()
}
