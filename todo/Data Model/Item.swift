//
//  Item.swift
//  todo
//
//  Created by Musa Beni on 22/10/2018.
//  Copyright © 2018 Musa Beni. All rights reserved.
//

import Foundation
import RealmSwift

class Item: Object  {
    @objc dynamic var title: String = ""
    @objc dynamic var dane: Bool = false
    @objc dynamic var datecreated:Date?
    
    let parentCategory = LinkingObjects(fromType: Category.self, property: "item")
}
