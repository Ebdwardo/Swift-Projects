//
//  DataViewController.swift
//  Homework1
//
//  Created by Eduardo Teodosio on 4/5/22.
//

import UIKit

class DataViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    var convTypes = ["Day 1", "Day 2", "Day 3", "Day 4", "Day 5", "Day 6", "Day 7"]
    
    var recs:PersonalRecords?
    var s:Float32?
    var d:Float32?
    var w:Float?
    var su:Float32?
    var sym:String?
    
    @IBOutlet weak var symptomsEntry: UITextView!
    @IBOutlet weak var DayPicker: UIPickerView!
    var rowSelection = 0
    
    @IBOutlet weak var systolic: UITextField!
    @IBOutlet weak var diastolic: UITextField!
    @IBOutlet weak var weightInPounds: UITextField!
    @IBOutlet weak var sugarLevel: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        symptomsEntry.layer.borderWidth = 0.5
        symptomsEntry.layer.cornerRadius = 5.0
        symptomsEntry.layer.borderColor = (UIColor.black).cgColor
        // remove this part later
//        systolic.text = "1"
//        diastolic.text = "1"
//        weightInPounds.text = "1"
//        sugarLevel.text = "1"
//        symptomsEntry.text = "None"
    }
    
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return convTypes.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return convTypes[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        rowSelection = row
    }

    @IBAction func submitData(_ sender: UIButton) {
        if (systolic.text != "" && diastolic.text != "" && weightInPounds.text != "" && sugarLevel.text != "" && symptomsEntry.text != ""){
            
            let sys = systolic.text!
            s = Float32(sys)
            
            let dys = diastolic.text!
            d = Float32(dys)
            
            let weight = weightInPounds.text!
            w = Float(weight)
            
            let sug = sugarLevel.text!
            su = Float32(sug)
            
            sym = String(symptomsEntry.text!)
            
            if (s != nil && d != nil && w != nil && su != nil && sym != nil){
                recs?.addInfo(key: convTypes[rowSelection] ,s: s!, d: d!, w: w!, m: su!, symp: sym!)
                
                
                let alert1 = UIAlertController(title: "Submited Data for: " + convTypes[rowSelection], message: "", preferredStyle: .alert)
                
                let dataInputAction = UIAlertAction(title: "Ok", style: .default)
                
                
                alert1.addAction(dataInputAction)
                
                self.present(alert1, animated: true, completion: nil)
                
//                systolic.text = "1"
//                diastolic.text = "1"
//                weightInPounds.text = "1"
//                sugarLevel.text = "1"
//                symptomsEntry.text = "None"

            }
            else{
                print("Enter Valid Data")
                
                
                
                let alert1 = UIAlertController(title: "Enter Valid Data", message: "", preferredStyle: .alert)
                
                let dataInputAction = UIAlertAction(title: "Ok", style: .default)
                
                
                alert1.addAction(dataInputAction)
                
                self.present(alert1, animated: true, completion: nil)
            }
        }
        else{
            print("Could not add Info")
            
            
            
            
            let alert1 = UIAlertController(title: "Enter Valid Data", message: "", preferredStyle: .alert)
            
            let dataInputAction = UIAlertAction(title: "Ok", style: .default)
            
            
            alert1.addAction(dataInputAction)
            
            self.present(alert1, animated: true, completion: nil)
        }
        
        let selected = DayPicker.selectedRow(inComponent: 0)
        DayPicker.selectRow(selected+1, inComponent: 0, animated: true)
        if(selected < convTypes.count-1){
            rowSelection = selected+1
        }
    }
}
