//
//  Marker.swift
//  MapBase
//
//  Created by Usuário Convidado on 17/03/16.
//  Copyright © 2016 Map Base 5. All rights reserved.
//

import UIKit


import RealmSwift
class Marker: Object {
    
    
    
    dynamic var id = ""
    
    dynamic var name = ""
    
    dynamic var address = ""
    
    dynamic var lat = 0.0
    
    dynamic var lon = 0.0
    
    
    override static func primaryKey() -> String? {
        return "id"
    }

    

    
/* let longPress: UILongPressGestureRecognizer = UILongPressGestureRecognizer(target: self, action: "loongPress: ")
longPress.allowableMovement = 10
longPress.minimumPressDuration = 1.0
self.mapView.addGestureRecognizer(longPress)








}


func loongPress(gesture: UIGestureRecognizer){
if(gesture.state == .Began){
let point: CGPoint = gesture.locationInView(self.mapView)
print("Long press x: \(point.x) | y: \(point.y)")
let coordenada: CLLocationCoordinate2D = self.mapView.converPoint(point, toCoordinateFromView: self.mapView)
print("Long press lat: \(coordenada.latitude) | logn: \(coordenada.longitude)")

let annot: CustomAnnot = CustomAnnot(coordinate: coordanada, title: "MEu ponto", subtitle: "Subtitulo")
self.meuMapa.addAnnotation(annot)
}
}
*/




}
