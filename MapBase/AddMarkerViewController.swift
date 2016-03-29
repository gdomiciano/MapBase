//
//  AddMarkerViewController.swift
//  MapBase
//
//  Created by Usuário Convidado on 22/03/16.
//  Copyright © 2016 Map Base 5. All rights reserved.
//

import UIKit

import RealmSwift

class AddMarkerViewController: UIViewController, UITextFieldDelegate {

    
    var markerID: String!
    
    var marker: Marker!
    
    let realm = try! Realm()
    
    //Variaveis que virao da Segue
    var lat: Double?
    var long: Double?
    
    @IBOutlet weak var markerName: UITextField!
    
    @IBOutlet weak var markerAddress: UITextField!
    
    
    
    @IBOutlet weak var labelLat: UILabel!
    
    
    @IBOutlet weak var labelLong: UILabel!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.markerName.delegate = self
        self.markerAddress.delegate = self
        print("Marker id" + markerID)
       // labelLat.text = lat as! String
        //labelLong.text = long as! String
        self.marker = realm.objectForPrimaryKey(Marker.self, key: markerID)!
        print(marker.name)
        
        if(self.marker.name == "Pino Criado Pelo Usuario"){
            markerName.placeholder = self.marker.name
            markerAddress.placeholder = self.marker.address

        }else{
            markerName.text = self.marker.name
            markerAddress.text = self.marker.address
        }
        
        
     
        
        labelLat.text = "\(self.marker.lat)"
        labelLong.text = "\(self.marker.lon)"
    
    
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }

    
    
    @IBAction func editMarkerFinish(sender: UIButton) {
    
            
            try! realm.write({() -> Void in
                self.marker.name = markerName.text!
                self.marker.address = markerAddress.text!
                realm.add(self.marker, update: true)
                
            })
            navigationController?.popViewControllerAnimated(true)
    }


}
