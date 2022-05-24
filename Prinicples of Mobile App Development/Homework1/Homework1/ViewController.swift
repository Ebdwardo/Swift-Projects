//
//  ViewController.swift
//  Homework1
//
//  Created by Eduardo Teodosio on 4/4/22.
//

import UIKit

class ViewController: UIViewController {
    
    //model
    var myPersonalRecords:PersonalRecords = PersonalRecords()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if (segue.identifier == "dataSegue"){
            if let viewController: DataViewController = segue.destination as? DataViewController {
                viewController.recs = myPersonalRecords
            }
        }
        
        if (segue.identifier == "healthSegue"){
            if let viewController: HealthViewController = segue.destination as? HealthViewController {
                viewController.recs = myPersonalRecords
            }
        }
    }
    
    @IBAction func unwind( seg: UIStoryboardSegue) {
        if let sourceViewController = seg.source as? DataViewController{
            myPersonalRecords = sourceViewController.recs!
        }
    }

}

