//
//  HealthViewController.swift
//  Homework1
//
//  Created by Eduardo Teodosio on 4/5/22.
//

import UIKit

class HealthViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    var recs:PersonalRecords?
    
    @IBOutlet weak var sbutton: UIButton!
    
    @IBOutlet weak var healthTable: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 140
    }
    

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (recs?.getCount())!
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
      
        let cell = tableView.dequeueReusableCell(withIdentifier: "healthCell", for: indexPath) as! HealthViewCell
        cell.layer.borderWidth = 1.0
        
        let keys = recs?.getRecord().keys
        let sortedKeys = Array(keys!).sorted(by:<)
        
        let index = indexPath.row
        
        let day = sortedKeys[index]
        
        
        let healthItem = recs?.getDayInfo(item: day)
        let sys = healthItem?.getSys()
        let dia = healthItem?.getDia()
        let weight = healthItem?.getWeight()
        let sug = healthItem?.getSug()
        
        
//        if(!summed){
//            if(index == (recs?.getCount())!-1){
//                currentSys = Float(sys!)!
//            }
//            if(index == (recs?.getCount())!-2){
//                previousSys = Float(sys!)!
//            }
//            if(index > (recs?.getCount())!-5){
//                last4 += Float(weight!)!
//            }
//            else{
//                first3 += Float(weight!)!
//            }
//            if(index == (recs?.getCount())!-1){
//                current = Float(sug!)!
//            }
//            if(index == (recs?.getCount())!-2){
//                previous = Float(sug!)!
//            }
//        }
        
        let sym = (healthItem?.getSymp())!
        
        cell.bPressure.text = sys! + "/" + dia!
        cell.weightLabel.text = weight
        cell.sLevel.text = sug
        cell.dayLabel.text = day
        cell.symptomsHolder.text = sym
        
        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if (segue.identifier == "symptomsSegue"){
            let cell = sender as! HealthViewCell

            if let viewController: SymptomsViewController = segue.destination as? SymptomsViewController {
                viewController.symtopms = cell.symptomsHolder.text!
            }
        }
        
        if (segue.identifier == "riskSegue"){
            if let viewController: RiskViewController = segue.destination as? RiskViewController {
                viewController.recs = recs
            }
        }
        
    }
    

}
