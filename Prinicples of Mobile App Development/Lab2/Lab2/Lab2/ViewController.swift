//
//  ViewController.swift
//  Lab2
//
//  Created by Eduardo Teodosio on 2/4/22.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var message: UILabel!
    @IBOutlet weak var weightLabel: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    @IBOutlet weak var goToMoon: UIButton!
    
   
    @IBAction func weightChange(_ sender: UITextField) {
        if !weightLabel.text!.isEmpty {
            goToMoon.isHidden = false;
        }
        else{
            goToMoon.isHidden = true;
        }
    }
   
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let des = segue.destination as! secondViewController
        if(segue.identifier == "toView2"){
            des.fromFirst = weightLabel.text!
        }
    }
    
    
    @IBAction func fromSecond(segue:UIStoryboardSegue){
        var fromSecond = "returned from view 2"
        print(fromSecond)
        
        if let sourceViewController = segue.source as? secondViewController{
            let dataRecieved = sourceViewController.fromFirst
            print(dataRecieved)
            message.text = sourceViewController.moonMessage
            message.isHidden = false
        }
        else{
            if let sourceViewController = segue.source as? thirdViewController{
                let dataRecieved = sourceViewController.fromSecond
                print(dataRecieved)
                message.text = sourceViewController.jupiterMessage
                message.isHidden = false
            }
            
        }
    }


}

