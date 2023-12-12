//
//  Category.swift
//  Todoey
//
//  Created by 뜌딩 on 12/12/23.
//  Copyright © 2023 App Brewery. All rights reserved.
//

import Foundation
import RealmSwift

class Category: Object {
  @Persisted var name: String = ""
  @Persisted var items: List<Item>
}
