//
//  SymptomsViewController.swift
//  Homework1
//
//  Created by Eduardo Teodosio on 4/5/22.
//

import UIKit

class SymptomsViewController: UIViewController {

    @IBOutlet weak var symptomsEntry: UITextView!
    var symtopms:String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        symptomsEntry.layer.borderWidth = 0.5
        symptomsEntry.layer.cornerRadius = 5.0
        symptomsEntry.layer.borderColor = (UIColor.black).cgColor
        
        symptomsEntry.text = symtopms
        // Do any additional setup after loading the view.
    }


}
