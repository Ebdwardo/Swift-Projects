//
//  CityTableViewCell.swift
//  Lab4
//
//  Created by Eduardo Teodosio on 2/28/22.
//

//import Foundation
import UIKit
class CityTableViewCell: UITableViewCell {
    @IBOutlet weak var cellCityImage: UIImageView!{
        didSet{
            cellCityImage.clipsToBounds = false
        }
    }
    
    @IBOutlet weak var cellCityName: UILabel!

    @IBOutlet weak var cellCityDescription: UILabel!
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}
