//
//  RiskViewController.swift
//  Homework1
//
//  Created by Eduardo Teodosio on 4/5/22.
//

import UIKit

class RiskViewController: UIViewController {
    @IBOutlet weak var weightLabel: UILabel!
    @IBOutlet weak var bloodLabel: UILabel!
    @IBOutlet weak var sugarLabel: UILabel!
    @IBOutlet weak var smilingFace: UIImageView!
    var sugarPlus10:Float32?
    var bloodPlus10:Float32?
    
    var recs:PersonalRecords?
    var healthy = true
    var totalDays:Int = 0
    
    var last4:Float = 0.0
    var first3:Float = 0.0
    
    var sugPrev:Float = 0.0
    var sugCurr:Float = 0.0
    
    var sysPrev:Float = 0.0
    var sysCurr:Float = 0.0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        totalDays = (recs?.getCount())!
        var counter = 0
        let records = recs?.getRecord()
        let keys = records!.keys
        let sortedKeys = Array(keys).sorted(by:<)
        
        for i in sortedKeys {
            let temp = records![i]
            let sys = temp!.getSys()
            _ = temp!.getDia()
            let weight = temp!.getWeight()
            let sug = temp!.getSug()
            
            if(counter == (totalDays-1)){
                sysCurr = Float(sys)!
            }
               
            if(counter == (totalDays-2)){
                sysPrev = Float(sys)!
            }
               
            if(counter > (totalDays-5)){
                last4 += Float(weight)!
            }
            else{
                first3 += Float(weight)!
            }
               
            if(counter == (totalDays-1)){
                sugCurr = Float(sug)!
            }
            if(counter == (totalDays-2)){
                sugPrev = Float(sug)!
            }
            
            counter += 1
        }
        
        let first3avg = first3/3.0
        let last4avg = last4/4.0
        sugarPlus10 = (sugPrev + (sugPrev*0.1))
        bloodPlus10 = (sysPrev + (sysPrev*0.1))
        
        if(totalDays == 7){
            if (last4avg > first3avg){
                weightLabel.text = "You are gaining weight!"
                weightLabel.isHidden = false
                weightLabel.textColor = UIColor.red
                healthy = false
            }
//            else{
//                healthy = true
//            }
            
            if(sysCurr >= bloodPlus10!){
                bloodLabel.text = "Your blood pressure is high!"
                bloodLabel.textColor = UIColor.blue
                bloodLabel.isHidden = false
                healthy = false
            }
//            else{
//                healthy = true
//            }
            
            if(sugCurr >= sugarPlus10!){
                sugarLabel.text = "Your sugar level is high"
                sugarLabel.textColor = UIColor.purple
                healthy = false
                sugarLabel.isHidden = false
            }
//            else{
//                healthy = true
//            }
            
            if(healthy){
                sugarLabel.text = "You are in good health, keep up the good work!"
                sugarLabel.textColor = UIColor.magenta
                sugarLabel.isHidden = false
                smilingFace.image = UIImage(named: "download.jpeg")
            }
        }
        else{
            weightLabel.text = "7 days worth of data need to be entered to calculate risks. Please enter data for more days"
            weightLabel.isHidden = false
        }
        
        
    }
    


}
