//
//  secondViewController.swift
//  Lab2
//
//  Created by Eduardo Teodosio on 2/4/22.
//

import UIKit

class secondViewController: UIViewController {
    
    var moonMessage = "Coming from the moon!"
    
    
    var fromFirst:String?
    var moonWeight:Double = 0
    @IBOutlet weak var message: UILabel!
    
    @IBOutlet weak var earth: UILabel!
    @IBOutlet weak var moon: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        message.text = "I feel much lighter!"
        var earthweight = Double(fromFirst!)!
        earthweight = round(earthweight)
        moonWeight = Double(fromFirst!)!*1/6
        moonWeight = round(moonWeight)
        earth.text = "Your weight on Earth is: \(earthweight) lbs"
        moon.text = "Your weight on the Moon is: \(moonWeight) lbs"
        print(fromFirst)
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
       
        if (segue.identifier == "toView3") {
            let des = segue.destination as!thirdViewController
            des.fromSecond = fromFirst
        }
    }
    
    @IBAction func fromThird(segue:UIStoryboardSegue){
        var fromThird = "returned from view 3"
        print(fromThird)
        
        if let sourceViewController = segue.source as? thirdViewController{
            let dataRecieved = sourceViewController.fromSecond
            print(dataRecieved)
            message.text = sourceViewController.jupiterMessage
        }
    }

}
