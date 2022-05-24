//
//  part2ViewController.swift
//  Lab1
//
//  Created by Eduardo Teodosio on 1/30/22.
//

import UIKit

class part2ViewController: UIViewController {
    
    var height:Float = 0
    var weight:Float = 0

    @IBOutlet weak var BMIResult: UILabel!
    
    @IBOutlet weak var resultsText: UILabel!
    
    @IBOutlet weak var heightDisp: UILabel!
    
    @IBOutlet weak var weightDisp: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func heightSlider(_ sender: UISlider) {
        height = sender.value
        heightDisp.text = String(height)
        calculateBMI()
    }
    
    @IBAction func weightSlider(_ sender: UISlider) {
        weight = sender.value
        weightDisp.text = String(weight)
        calculateBMI()
    }
    
    func calculateBMI() -> Void{
        let BMI:Float = ((weight/(height*height))*703)
        BMIResult.text = String(BMI)
        BMIResult.isHidden = false
        heightDisp.isHidden = false
        weightDisp.isHidden = false
        
        if BMI < 18{
            resultsText.text = "You are underweight"
            resultsText.textColor = UIColor.blue
            resultsText.isHidden = false
        }
        else if (BMI>=18 && BMI < 25){
            resultsText.text = "You are normal"
            resultsText.textColor = UIColor.green
            resultsText.isHidden = false
        }
        else if (BMI>=25 && BMI < 30 ){
            resultsText.text = "You are pre-obese"
            resultsText.textColor = UIColor.purple
            resultsText.isHidden = false
        }
        else{
            resultsText.text = "You are obese"
            resultsText.textColor = UIColor.red
            resultsText.isHidden = false
        }
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
