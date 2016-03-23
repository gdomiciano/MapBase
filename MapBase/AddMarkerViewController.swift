//
//  AddMarkerViewController.swift
//  MapBase
//
//  Created by Usuário Convidado on 22/03/16.
//  Copyright © 2016 Map Base 5. All rights reserved.
//

import UIKit

class AddMarkerViewController: UIViewController {

    
    
    
    //Variaveis que virao da Segue
    var lat: Double?
    var long: Double?
    
    @IBOutlet weak var markerName: UITextField!
    
    @IBOutlet weak var markerAddress: UITextField!
    
    
    
    @IBOutlet weak var labelLat: UILabel!
    
    
    @IBOutlet weak var labelLong: UILabel!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        labelLat.text = lat as! String
        labelLong.text = long as! String
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    
    func addMarkerToArray(){
        var marker: Marker = Marker()
        marker.lat = lat!
        marker.lon = long!
        marker.name = markerName.text!
        marker.address = markerAddress.text!
    
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
