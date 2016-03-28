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

class ItensInMapViewController: UIViewController, CLLocationManagerDelegate {
    
    
    
    var map: Map = Map()
    
    
    //Vem da Segue
    var idMap: String!
    

    @IBOutlet var mapItensView: MKMapView!
    
    
    let locationManager:CLLocationManager = CLLocationManager()
    
    let realm = try! Realm()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
      

        self.locationManager.requestWhenInUseAuthorization()

        
        self.locationManager.delegate = self
        
        self.map = realm.objectForPrimaryKey(Map.self, key: idMap)!
        print(idMap)
        print (map.name)
        let longPress: UILongPressGestureRecognizer = UILongPressGestureRecognizer(target: self, action: "loongPress:")
        longPress.allowableMovement = 10
        longPress.minimumPressDuration = 1.0
        
        self.mapItensView.addGestureRecognizer(longPress)
        
        if(CLLocationManager.locationServicesEnabled()){
            locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
           self.mapItensView.showsUserLocation = true
            let locValue:CLLocationCoordinate2D = locationManager.location!.coordinate
            let userLocation: CLLocationCoordinate2D = CLLocationCoordinate2DMake(locValue.latitude, locValue.longitude)
            
            //Regiao a partir do usuario
            
            self.mapItensView.region =  MKCoordinateRegionMakeWithDistance(userLocation, 1200, 1200)

            
        }
        
        putAnnotationsFromDatabase()
        
    }
    
    
    
    
    
    
    
    
    
    override func viewWillAppear(animated: Bool) {
        putAnnotationsFromDatabase()
    }
    
    
    
    func putAnnotationsFromDatabase() -> Void{
        self.mapItensView.removeAnnotations(self.mapItensView.annotations)
        
        if(!map.markers.isEmpty){
            for marker in map.markers{
                let coordenada: CLLocationCoordinate2D = CLLocationCoordinate2DMake(marker.lat,marker.lon)

                let annot: MapMarker = MapMarker(coordinate: coordenada, title: marker.name, subtitle: marker.address, id: marker.id)
                self.mapItensView.addAnnotation(annot)
            }
        }
        
    }
    
    
    
    
    
    
    

    
    
    func loongPress(gesture: UIGestureRecognizer){
        if(gesture.state == .Began){
            let point: CGPoint = gesture.locationInView(self.mapItensView)
            print("Long press x: \(point.x) | y: \(point.y)")
            
            
            let coordenada: CLLocationCoordinate2D = self.mapItensView.convertPoint(point, toCoordinateFromView: self.mapItensView)
            print("Long press lat: \(coordenada.latitude) | logn: \(coordenada.longitude)")
            let marker: Marker = Marker()

            marker.id = NSUUID().UUIDString

            let annot: MapMarker = MapMarker(coordinate: coordenada, title: "Pino Criado pelo Usuario", subtitle: "Endereco", id: marker.id)
            self.mapItensView.addAnnotation(annot)
            
            //Ja ira criar o Pino e adicionar ao Map para depois somente editar

            
            marker.name = "Pino Criado Pelo Usuario"
            marker.address = "Endereco"
            marker.lat = coordenada.latitude
            marker.lon = coordenada.longitude
            
            
            try! realm.write{
                map.markers.append(marker)

                realm.add(map, update: true)
            }
            
            
            
        }
        
        
        
        
        
    }
    

    
    
    func mapView(mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
        
        var i: MapMarker = view.annotation as! MapMarker
       performSegueWithIdentifier("mapToAddMarkerSegue", sender: i.id)
        
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if (segue.identifier == "mapToAddMarkerSegue"){
            var vc: AddMarkerViewController = segue.destinationViewController as! AddMarkerViewController
            vc.markerID = sender as! String
        }
    
    
    }
    
    
    
    
    
    
        
        
        func mapView(mapView: MKMapView, viewForAnnotation annotation: MKAnnotation) -> MKAnnotationView? {
            
            //Verificar se ja existe uma marcacao ja existe para utiliza la
            //Com isso e possivel termos varios reuseID para marcarmos coisas customizadas diferentes no mapa
            if annotation is MapMarker{
                let reuseId = "reuseMapMarkerAnnotation"
                var anView = mapView.dequeueReusableAnnotationViewWithIdentifier(reuseId)
                if(anView == nil){
                    anView = MKAnnotationView(annotation: annotation, reuseIdentifier: reuseId)
                    anView!.image = UIImage(named: "marker")
                    anView!.canShowCallout = true
                    anView!.rightCalloutAccessoryView = UIButton(type: UIButtonType.DetailDisclosure)
                }
                return anView
            }
            
            
            if(annotation is MKUserLocation){
                let reuseId = "reuseMyLocation"
                var anView = mapView.dequeueReusableAnnotationViewWithIdentifier(reuseId)
                if(anView == nil){
                    anView = MKAnnotationView(annotation: annotation, reuseIdentifier: reuseId)
                    anView!.image = UIImage(named: "userLogo")
                    anView!.canShowCallout = false
                }
                return anView
            }
            
            
            
            return nil
        }
    
    
    
    
    
    
    
    //End Class
        
}




    


