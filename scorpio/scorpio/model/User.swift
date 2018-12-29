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
}
