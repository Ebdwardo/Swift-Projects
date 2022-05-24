//
//  SecondViewController.swift
//  Lab5CoreData
//
//  Created by Eduardo Teodosio on 3/12/22.
//

import UIKit

class SecondViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    var cityImage: NSData?
    var cityDescription: String?
    
    @IBOutlet weak var secondImage: UIImageView!
    
    @IBOutlet weak var descriptionLabel: UILabel!
    
    @IBOutlet weak var imageSource: UISegmentedControl!

    let picker = UIImagePickerController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        picker.delegate = self
        
        secondImage.image = UIImage(data: (cityImage! as Data))
        descriptionLabel.text = cityDescription!
    }
    
    @IBAction func changeImage(_ sender: UIButton) {
        if imageSource.selectedSegmentIndex == 0{
            if UIImagePickerController.isSourceTypeAvailable(.camera){
                picker.allowsEditing = false
                picker.sourceType = UIImagePickerController.SourceType.camera
                picker.cameraCaptureMode = .photo
                picker.modalPresentationStyle = .fullScreen
                present(picker, animated: true, completion: nil)
            }
            else{
                print("No Camera")
            }
        }
        else{
            picker.allowsEditing = false
            picker.sourceType = .photoLibrary
            picker.mediaTypes = UIImagePickerController.availableMediaTypes(for: .photoLibrary)!
            picker.modalPresentationStyle = .popover
            present(picker, animated: true, completion: nil)
        }
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        picker .dismiss(animated: true, completion: nil)

        // fetch resultset has the recently added row without the image
        // this code ad the image to the row
        let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage
        
        secondImage.image = image
    }
    
}
