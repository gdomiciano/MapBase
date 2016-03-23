//
//  MapListTableViewController.swift
//  MapBase
//
//  Created by Joao Victor on 17/03/16.
//  Copyright © 2016 Map Base 5. All rights reserved.
//

import UIKit

import RealmSwift

class MapListTableViewController: UITableViewController {
    
    var arrayMapTeste: [String]=["Chapeus", "Botas", "Relógios", "Família", "Bolsas", "Casa de Massagem"]

    var arrayMap:[Map] = []
    
    var type: String = ""
    var isBookmarked:  Bool = false
    var maps: Results<Map>?
    
    let realm = try! Realm()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //tableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: "CellIdentifier")
        
        writeTestDatabase()
        readDatabaseAndUpdateUI()
        
     
    }
    
    
    func readDatabaseAndUpdateUI(){
        
        
        switch (type){
            case "Private":
                maps = realm.objects(Map).filter("type = 'Private'")

            case "Public":
                maps = realm.objects(Map).filter("type = Public")
            
                default:
            maps = realm.objects(Map)

        }
    
        
       // maps = realm.objectForPrimaryKey(Map, key: Map.primaryKey()!)
        
    }
    
    
    
    func writeTestDatabase(){
        let map =  Map()
        let mark1 = Marker()
        let mark2 = Marker()
        let mark3 = Marker()
        
        mark1.name = "Lugar1"
        mark1.lat = -43.56666
        mark1.lon = -23.56566
        mark1.address = "Rua 1 Do Lugar 1"
        mark1.id = NSUUID().UUIDString
        mark2.name = "Lugar2"
        mark2.lat = -34.56666
        mark2.lon = -14.56566
        mark2.address = "Rua 2 Do Lugar 2"
        mark2.id = NSUUID().UUIDString
        
        
        mark3.name = "Lugar3"
        mark3.lat = -65.56666
        mark3.lon = -12.56566
        mark3.address = "Rua 3 Do Lugar 3"
        mark3.id = NSUUID().UUIDString
        
        var marks: [Marker] = [Marker]()
        
        marks.append(mark1)
        
        marks.append(mark2)
        
        marks.append(mark3)
        
        map.name = "Mapa 1"
        map.id = NSUUID().UUIDString
        map.type = "Private"
        map.isBookmarked = false
        map.markers.appendContentsOf(marks)
        
        try! realm.write({() -> Void in
            realm.add([map])
            
        })

    }
    
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        
        return  (maps?.count)!
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell{
        
        let cell = tableView.dequeueReusableCellWithIdentifier("CellId", forIndexPath: indexPath) as UITableViewCell
        //let listMaps = self.arrayMapTeste[indexPath.row]
        let listMaps = maps?[indexPath.row]
        cell.textLabel?.text = listMaps?.name
        return cell
    }

    

    
    
    
    
    

    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData() // [2]
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
