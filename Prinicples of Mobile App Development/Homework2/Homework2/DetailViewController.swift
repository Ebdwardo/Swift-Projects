//
//  DetailViewController.swift
//  Homework2
//
//  Created by Eduardo Teodosio on 4/19/22.
//

import UIKit

class DetailViewController: UIViewController,UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    var selectedCity:String?
    var selectedDescription:String?
    
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var selectedImage: UIImageView!
    @IBOutlet weak var desc: UILabel!
    
    var photo = UIImage(named: "Tempe.jpeg")
    
    
    @IBOutlet weak var imageSource: UISegmentedControl!
    let picker = UIImagePickerController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        picker.delegate = self
        selectedImage.image = photo
        
        name.text = selectedCity!
        desc.text = selectedDescription!
        // Do any additional setup after loading the view.
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
        
        selectedImage.image = image
    }
    @IBAction func changeDescription(_ sender: UIButton) {
        let alert = UIAlertController(title: "Change City Description", message: "", preferredStyle: .alert)
        
        let okAction = UIAlertAction(title: "Ok", style: .default) { [self] (aciton) in
            
            let first = alert.textFields![0] as UITextField
            desc.text! = first.text!
            
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel) { (action) in
        }
        alert.addTextField { (textField) in
            textField.placeholder = "New City Description"
        }
        alert.addAction(okAction)
        alert.addAction(cancelAction)
        self.present(alert, animated: true, completion: nil)
    }
    
}
