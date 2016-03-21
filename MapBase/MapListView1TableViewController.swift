//
//  MapListView1TableViewController.swift
//  MapBase
//
//  Created by Joao Victor on 17/03/16.
//  Copyright © 2016 Map Base 5. All rights reserved.
//

import UIKit
import Firebase

class MapListView1TableViewController: UITableViewController {
    
    var arrayMapTeste: [String]=["Motos", "Carros", "Bancos", "Cinemas", "Baladas"]

    var firebaseRef = Firebase(url:"https://boiling-fire-3533.firebaseio.com")

    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
        
        // myRootRef.setValue("MapBase Aula1 Public Table")
        
        firstLoad()
        
        firebaseRef.observeEventType(.Value, withBlock: {
            snapshot in
            print("\(snapshot.key) -> \(snapshot.value)")
        })
        
    }
    
    func firstLoad() {
        let casadochapeu = ["lat": "-23.342", "lon": "-45.4387834", "name":"Casa do Chapéu", "address":"Av. Lins 1222"]
        let chapelariamaluca = ["lat": "-24.342", "lon": "-46.4387834", "name":"Chapelaria Maluca", "address":"Av. Lins 2221"]
        
        var arrayMarkers: [[String:String]] = [[String:String]]()
        
        arrayMarkers.append(casadochapeu)
        arrayMarkers.append(chapelariamaluca)
        
        let markersRef = firebaseRef.childByAppendingPath("markers")
        markersRef.setValue(arrayMarkers)
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
        let listMaps = self.arrayMapTeste[indexPath.row]
        cell.textLabel?.text = listMaps
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
