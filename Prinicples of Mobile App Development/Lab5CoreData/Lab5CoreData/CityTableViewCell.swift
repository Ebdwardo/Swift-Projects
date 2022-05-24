//
//  CityTableViewCell.swift
//  Lab5CoreData
//
//  Created by Eduardo Teodosio on 3/12/22.
//

import Foundation
import UIKit

class CityTableViewCell : UITableViewCell{
    
    @IBOutlet weak var cellCityImage: UIImageView!{
        didSet{
            cellCityImage.clipsToBounds = true
        }
    }
    
    @IBOutlet weak var cityName: UILabel!
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    
    
}
