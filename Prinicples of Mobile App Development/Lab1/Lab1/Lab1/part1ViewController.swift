//
//  part1ViewController.swift
//  Lab1
//
//  Created by Eduardo Teodosio on 1/30/22.
//

import UIKit

class part1ViewController: UIViewController {

    @IBOutlet weak var heightText: UITextField!
    
    @IBOutlet weak var weightText: UITextField!
    
    @IBOutlet weak var BMIButton: UILabel!
    
    @IBOutlet weak var resultsLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func BMIButton(_ sender: Any) {
        let height = Float(heightText.text!)
        let weight = Float(weightText.text!)
        
        let BMI:Float = ((weight!/(height!*height!))*703)
        
        BMIButton.text = String(BMI)
        BMIButton.isHidden = false
        
        if BMI < 18{
            BMIButton.textColor = UIColor.blue
            BMIButton.textColor = UIColor.blue
            resultsLabel.text = "You are underweight"
            resultsLabel.isHidden = false
        }
        else if (BMI>=18 && BMI < 25){
            BMIButton.textColor = UIColor.green
            resultsLabel.textColor = UIColor.green
            resultsLabel.text = "You are normal"
            resultsLabel.isHidden = false
        }
        else if (BMI>=25 && BMI < 30 ){
            BMIButton.textColor = UIColor.purple
            resultsLabel.textColor = UIColor.purple
            resultsLabel.text = "You are pre-obese"
            resultsLabel.isHidden = false
        }
        else{
            BMIButton.textColor = UIColor.red
            resultsLabel.textColor = UIColor.red
            resultsLabel.text = "You are obese"
            resultsLabel.isHidden = false
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
