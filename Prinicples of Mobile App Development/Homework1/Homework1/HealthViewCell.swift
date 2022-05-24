//
//  HealthViewCell.swift
//  Homework1
//
//  Created by Eduardo Teodosio on 4/5/22.
//

//import Foundation
import UIKit
class HealthViewCell: UITableViewCell {
    
    @IBOutlet weak var symptomsHolder: UILabel!
    @IBOutlet weak var dayLabel: UILabel!
    
    @IBOutlet weak var bPressure: UILabel!
    
    @IBOutlet weak var sLevel: UILabel!
    
    @IBOutlet weak var weightLabel: UILabel!
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
}
