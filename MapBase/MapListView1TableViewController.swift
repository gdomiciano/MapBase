//
//  MapListView1TableViewController.swift
//  MapBase
//
//  Created by Joao Victor on 17/03/16.
//  Copyright © 2016 Map Base 5. All rights reserved.
//

import UIKit
import Firebase
import MapKit

class MapListView1TableViewController: UITableViewController, MKMapViewDelegate {
    
    var arrayMapTeste: [String] = []
    
    var firebaseRef = Firebase(url:"https://boiling-fire-3533.firebaseio.com")
    
    var publicMapsRef = Firebase(url:"https://boiling-fire-3533.firebaseio.com/publicMaps")
    var markersRef = Firebase(url:"https://boiling-fire-3533.firebaseio.com/markers")
    var markers: [Int]?
    
    var customMarkers:[MapMarker] = [MapMarker]()
    

    override func viewDidLoad() {
        super.viewDidLoad()


        
        publicMapsRef.observeEventType(.ChildAdded, withBlock: { snapshot in
            if let dic = snapshot.value as? [String: AnyObject] {
                if let nome = dic["name"] as? String {
                    self.arrayMapTeste.append(nome)
                }
                if let mapMarkers = dic["markers"] as? [Int] {
                    //print(mapMarkers)
                    self.markers = mapMarkers
                }
            }
            self.tableView.reloadData()
        })
        loadMarkers()
        
    }
    
    func loadMarkers() {
        markersRef.observeEventType(.Value, withBlock: { snapshot in
            for(var i:Int = 0; i < self.markers?.count; i++){
                if let item = snapshot.childSnapshotForPath(String(self.markers![i])) {
                    if let marker = item.value as? [String: AnyObject] {
                        
                        
                        let lat:Double = Double(marker["lat"] as! String)!
                        let log:Double = Double(marker["lon"] as! String)!
                        let name:String = marker["name"] as! String
                        let address:String = marker["address"] as! String
                        let id:String = item.key
                        self.customMarkers.append(MapMarker(coordinate: CLLocationCoordinate2DMake(lat, log), title: name, subtitle:address, id: id))
                       
                    }

                }
            }
            
        })
    }
    
    func saveMaps() {
        let markers: [Int] = [0, 1]
        let hatStores = ["name": "Lojas de chapéu", "markers": markers]
        
        publicMapsRef.setValue([hatStores])
        
    }
    func saveMarkers() {
        let casadochapeu = ["lat": "-23.342", "lon": "-45.4387834", "name":"Casa do Chapéu", "address":"Av. Lins 1222"]
        let chapelariamaluca = ["lat": "-24.342", "lon": "-46.4387834", "name":"Chapelaria Maluca", "address":"Av. Lins 2221"]
        
        var arrayMarkers: [[String:String]] = [[String:String]]()
        
        arrayMarkers.append(casadochapeu)
        arrayMarkers.append(chapelariamaluca)
        
        markersRef.setValue(arrayMarkers)
    }
    
    func firstLoad() {
        saveMarkers()
        saveMaps()
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return arrayMapTeste.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell{
        let cell = tableView.dequeueReusableCellWithIdentifier("CellId", forIndexPath: indexPath) as UITableViewCell
        cell.textLabel?.text = self.arrayMapTeste[indexPath.row]
        return cell
    }

    

    /*
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("reuseIdentifier", forIndexPath: indexPath)

        // Configure the cell...

        return cell
    }
    */

    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
