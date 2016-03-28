//
//  CreateMapViewController.swift
//  MapBase
//
//  Created by Usuário Convidado on 22/03/16.
//  Copyright © 2016 Map Base 5. All rights reserved.
//

import UIKit

import RealmSwift

class CreateMapViewController: UIViewController {
    
    
    
    @IBOutlet weak var mapName: UITextField!
    
    
    
    
    @IBOutlet weak var typeSegmented: UISegmentedControl!
    
    
    
    @IBAction func createMap(sender: UIButton) {
        let map: Map =  Map()
        map.name = mapName.text!
        map.id = NSUUID().UUIDString
        switch (typeSegmented.selectedSegmentIndex) {
        case 0:
            map.type = "Private"
        case 1:
            map.type = "Public"
            
        default:
            map.type = "Private"
        }
        
        map.isBookmarked = false
        //print (map.name)
        let realm = try! Realm()
        
        try! realm.write({() -> Void in
            realm.add(map)
            
        })
        //self.dismissViewControllerAnimated(true, completion: nil)
        navigationController?.popViewControllerAnimated(true)
        
        
    }
    
    
    
    

    override func viewDidLoad() {
        super.viewDidLoad()

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
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
