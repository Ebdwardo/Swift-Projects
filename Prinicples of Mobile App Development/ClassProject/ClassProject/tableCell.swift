//
//  tableCell.swift
//  ClassProject
//
//  Created by Eduardo Teodosio on 3/20/22.
//

import Foundation
import UIKit

class tableCell : UITableViewCell{
    
    @IBOutlet weak var cellImage: UIImageView!{
    didSet{
        cellImage.clipsToBounds = true
    }
}
    
    @IBOutlet weak var cellName: UILabel!
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    
    
}
