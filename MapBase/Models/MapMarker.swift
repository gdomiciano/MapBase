//
//  MapMarker.swift
//  MapBase
//
//  Created by Usuário Convidado on 17/03/16.
//  Copyright © 2016 Map Base 5. All rights reserved.
//

import UIKit
import MapKit



class MapMarker: NSObject, MKAnnotation {
    
    var coordinate: CLLocationCoordinate2D
    var title:String?
    var subtitle:String?
    
    init(coordinate:CLLocationCoordinate2D, title: String, subtitle: String){
        self.coordinate = coordinate
        self.title = title
        self.subtitle = subtitle
    }
    
    
}
