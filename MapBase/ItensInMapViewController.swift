//
//  ItensInMapViewController.swift
//  MapBase
//
//  Created by Usuário Convidado on 22/03/16.
//  Copyright © 2016 Map Base 5. All rights reserved.
//

import UIKit

import RealmSwift


import MapKit

class ItensInMapViewController: UIViewController {
    
    
    
    var map: Map = Map()
    
    
    //Vem da Segue
    var idMap: String!
    

    @IBOutlet var mapItensView: MKMapView!
    

    
    let realm = try! Realm()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.map = realm.objectForPrimaryKey(Map.self, key: idMap)!
        print(idMap)
        print (map.name)
        let longPress: UILongPressGestureRecognizer = UILongPressGestureRecognizer(target: self, action: "loongPress: ")
        longPress.allowableMovement = 10
        longPress.minimumPressDuration = 1.0
        
         self.mapItensView.addGestureRecognizer(longPress)
        
    }
    
    
    func loongPress(gesture: UIGestureRecognizer){
        if(gesture.state == .Began){
            let point: CGPoint = gesture.locationInView(self.mapItensView)
            print("Long press x: \(point.x) | y: \(point.y)")
            
            
            let coordenada: CLLocationCoordinate2D = self.mapItensView.convertPoint(point, toCoordinateFromView: self.mapItensView)
            print("Long press lat: \(coordenada.latitude) | logn: \(coordenada.longitude)")
            
            let annot: MapMarker = MapMarker(coordinate: coordenada, title: "Ponto 1", subtitle: "Subtitulo")
            self.mapItensView.addAnnotation(annot)
        }
    }
    
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
