//
//  ItensInMapViewController.swift
//  MapBase
//
//  Created by Usuário Convidado on 22/03/16.
//  Copyright © 2016 Map Base 5. All rights reserved.
//

import UIKit

import RealmSwift
import Firebase

import MapKit

class ItensInMapViewController: UIViewController, CLLocationManagerDelegate {
    
    var firebaseRef = Firebase(url:"https://boiling-fire-3533.firebaseio.com")
    
    var publicMapsRef = Firebase(url:"https://boiling-fire-3533.firebaseio.com/publicMaps")
    var markersRef = Firebase(url:"https://boiling-fire-3533.firebaseio.com/markers")
    var markers: [Int]?
    
    var map: Map = Map()
    var publicMap: [String: AnyObject]?
    
    //Vem da Segue
    var idMap: String!
    
    var isFromPublic: Bool = false
    

    @IBOutlet var mapItensView: MKMapView!
    
    
    
    
    
    
    
    let locationManager:CLLocationManager = CLLocationManager()
    
    let realm = try! Realm()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
      

        self.locationManager.requestWhenInUseAuthorization()

        
        self.locationManager.delegate = self
        
        
        locationManager.delegate = self
        if(CLLocationManager.locationServicesEnabled()){
            locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
            self.mapItensView.showsUserLocation = true
            //print(locationManager.location?.coordinate)
            let locValue:CLLocationCoordinate2D = locationManager.location!.coordinate
            
            let userLocation: CLLocationCoordinate2D = CLLocationCoordinate2DMake(locValue.latitude, locValue.longitude)
            
            //Regiao a partir do usuario
            
            self.mapItensView.region =  MKCoordinateRegionMakeWithDistance(userLocation, 1200, 1200)
            
            
        }
        
        
        
        
        if(!isFromPublic ){
            self.map = realm.objectForPrimaryKey(Map.self, key: idMap)!
            
            print(idMap)
            print (map.name)
            
            let longPress: UILongPressGestureRecognizer = UILongPressGestureRecognizer(target: self, action: "loongPress:")
            longPress.allowableMovement = 10
            longPress.minimumPressDuration = 1.0
            
            self.mapItensView.addGestureRecognizer(longPress)
             putAnnotationsFromDatabase()
        }else{
            putAnnotationsFromJSON()
        }
        
        
       
        
        
        
        
        
       
        
    }
    
    
    
   var markerArrayFirebase: Marker = Marker()
    
    func putAnnotationsFromJSON(){
    self.mapItensView.removeAnnotations(self.mapItensView.annotations)
        
        
        if let mapMarkers = publicMap!["markers"] as? [[String: AnyObject]] {
            
            for marker in mapMarkers{
                if let lat = marker["lat"] as? Double {
                    print(marker["lat"])
                    print (marker)
                    if let  lon = marker["lon"] as? Double{
                        let coordenada: CLLocationCoordinate2D = CLLocationCoordinate2DMake(lat , lon)
                        let annot: MapMarker = MapMarker(coordinate: coordenada, title: marker["name"] as! String, subtitle:  marker["address"] as! String, id: "")
                        self.mapItensView.addAnnotation(annot)
                    }
                }
                
                
            }
            
            
        }
    
    }
    
    
    override func viewWillAppear(animated: Bool) {
        if(!self.isFromPublic){
        self.putAnnotationsFromDatabase()
        }
    }
    
    
    
    func putAnnotationsFromDatabase() -> Void{
        if(!map.markers.isEmpty){
            self.mapItensView.removeAnnotations(self.mapItensView.annotations)
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
                    
                    if(!isFromPublic){
                    anView!.rightCalloutAccessoryView = UIButton(type: UIButtonType.DetailDisclosure)
                        
                    }
                    
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
    
    
    
    
    
    @IBAction func turnMapToPublic(sender: UIBarButtonItem){
        /* let json: [String: Any?] = ["id": map.id, "name": map.name,
            "markers": [
        ]*/
        
        var markersArray: [[String:AnyObject]] = [[String: AnyObject]]()
        
        for marker in map.markers{
            let mapMarkerJson: [String: AnyObject] =   ["name": marker.name,
                "address": marker.address,
                "lat": marker.lat,
                "lon": marker.lon ]
            markersArray.append(mapMarkerJson)
        }
        
        
        
        /*
        let mapMarkersJson: [String: AnyObject] =
        ["name": map.markers[0].name,
            "address": map.markers[0].address,
            "lat": map.markers[0].lat,
            "lon": map.markers[0].lon ]
        
        
        let mapMarkersJson2: [String: AnyObject] =
        ["name": map.markers[1].name,
            "address": map.markers[1].address,
            "lat": map.markers[1].lat,
            "lon": map.markers[1].lon ]
        */
        
       // var markersArray = [mapMarkersJson, mapMarkersJson2]
        
        
        let mapJson: [String: AnyObject] = ["name": map.name, "markers": markersArray]

        let postRef = publicMapsRef.childByAutoId()
        postRef.setValue(mapJson)
        
    }
    
    
    
    //End Class
        
}




    


