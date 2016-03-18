//
//  Map.swift
//  MapBase
//
//  Created by Usuário Convidado on 17/03/16.
//  Copyright © 2016 Map Base 5. All rights reserved.
//

import UIKit

import RealmSwift

class Map: Object {

    dynamic var id = ""
    
    dynamic var nome = ""
    
    dynamic var type = ""
    
    dynamic var isBookmarked = false
    
    var markers = List<Marker>()
    
    
    override static func primaryKey() -> String? {
        return "id"
    }

    
}
