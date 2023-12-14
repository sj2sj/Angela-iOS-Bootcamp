//
//  Item.swift
//  Todoey
//
//  Created by 뜌딩 on 12/12/23.
//  Copyright © 2023 App Brewery. All rights reserved.
//

import Foundation
import RealmSwift

class Item: Object {
  @Persisted var title: String = ""
  @Persisted var done: Bool = false
  @Persisted var dateCreated: Date?
  @Persisted(originProperty: "items") var parentCategory: LinkingObjects<Category>
}
