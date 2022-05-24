//
//  DetailViewController.swift
//  Lab4
//
//  Created by Eduardo Teodosio on 2/28/22.
//

import UIKit

class DetailViewController: UIViewController {

    var selectedCity:String?
    var selectedDescription:String?
    
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var selectedImage: UIImageView!
    @IBOutlet weak var descripton: UILabel!
        
    override func viewDidLoad() {
        super.viewDidLoad()

        selectedImage.image = UIImage(named: "\(selectedCity!).jpeg")
        
        name.text = selectedCity!
        descripton.text = selectedDescription!
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
