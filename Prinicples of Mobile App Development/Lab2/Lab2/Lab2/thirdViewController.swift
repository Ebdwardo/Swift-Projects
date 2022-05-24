//
//  thirdViewController.swift
//  Lab2
//
//  Created by Eduardo Teodosio on 2/4/22.
//

import UIKit

class thirdViewController: UIViewController {
    
    var fromSecond:String?
    var jupiterMessage = "Coming from Jupiter!"
    
    @IBOutlet weak var earth: UILabel!
    @IBOutlet weak var moon: UILabel!
    @IBOutlet weak var jupiter: UILabel!
    
    
    @IBOutlet weak var message: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        message.text = "I feel much heavier!"
        var jupiterweight = 2.4*Double(fromSecond!)!
        var moonweight = round((1/6)*Double(fromSecond!)!)
        earth.text = "Your weight on Earth is: \(fromSecond!) lbs"
        moon.text = "Your weight on the Moon is: \(moonweight) lbs"
        jupiter.text = "Your weight on Jupiter is: \(jupiterweight) lbs"
        
        
        
        
        
        print(fromSecond)

        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
