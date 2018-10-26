//
//  Category.swift
//  todo
//
//  Created by Musa Beni on 22/10/2018.
//  Copyright © 2018 Musa Beni. All rights reserved.
//

import Foundation
import RealmSwift

class Category: Object {
    @objc dynamic var name: String = ""
    let item = List<Item>()
    
}
