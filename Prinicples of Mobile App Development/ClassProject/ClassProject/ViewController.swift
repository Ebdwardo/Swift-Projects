//
//  ViewController.swift
//  ClassProject
//
//  Created by Eduardo Teodosio on 3/20/22.
//

import UIKit
import CoreData

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UIImagePickerControllerDelegate & UINavigationControllerDelegate {

    @IBOutlet weak var locationTableView: UITableView!
    let photoPicker = UIImagePickerController ()
    
    var selectedCity:Location?

    
    override func viewDidLoad() {
        super.viewDidLoad()
        photoPicker.delegate = self
        // Do any additional setup after loading the view.
        m = Loc(context: managedObjectContext)

    }
    
    let managedObjectContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    var m:Loc?
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return m!.fetchRecord()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // add each row from coredata fetch results
        let cell = tableView.dequeueReusableCell(withIdentifier: "tCell", for: indexPath) as! tableCell
        
        let item = m?.fetchedResults[indexPath.row]

        
        cell.cellName.text = item?.name!
        cell.cellImage.image = UIImage(data: (item?.picture)! as Data)
        return cell
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool
    {
        return true
    }
    // return the table view style as deletable
    
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle { return UITableViewCell.EditingStyle.delete }
    
    
    // implement delete function
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath)
    {
        
        if editingStyle == .delete
        {
            
            // delete the selected object from the managed
            // object context
            managedObjectContext.delete((m?.fetchedResults[indexPath.row])!)
            // remove it from the fetch results array
            m?.fetchedResults.remove(at:indexPath.row)
            
            do {
                // save the updated managed object context
                try managedObjectContext.save()
            } catch {
                
            }
            // reload the table after deleting a row
            locationTableView.reloadData()
        }
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    //  Set the row height for the first (zeroth) cell in all section(s) to 100, and set all other cells to 50.
    //  You can also set the row height for all cells in a section by accessing indexPath.section.
        return 200
        
    }
    
    
    
    @IBAction func addPlace(_ sender: UIBarButtonItem) {
        let alert2 = UIAlertController(title: "Add A Place", message: "", preferredStyle: .alert)
        
        let searchAction1 = UIAlertAction(title: "Ok", style: .default) { (aciton) in
            
            let firstTextField = alert2.textFields![0] as UITextField
            let secondTextField = alert2.textFields![1] as UITextField
            
            if let x = firstTextField.text, let y = secondTextField.text{
                print(firstTextField.text!)
                print(secondTextField.text!)
                
                // create a new entity object
                let ent = NSEntityDescription.entity(forEntityName: "Location", in: self.managedObjectContext)
                //add to the manege object context
                let newItem = Location(entity: ent!, insertInto: self.managedObjectContext)
                newItem.name = x
                newItem.address = y
                let image = UIImage(named: "tempe.jpeg")
                newItem.picture = image?.pngData() as NSData?
                
                // show the alert controller to select an image for the row
                
                // save the updated context
                do {
                    try self.managedObjectContext.save()
                } catch _ {
                }
                
                let alertController = UIAlertController(title: "Add A Picture?", message: "", preferredStyle: .alert)
                
                let searchAction = UIAlertAction(title: "Picture", style: .default) { (aciton) in
                    // load image
                    self.photoPicker.allowsEditing = false
                    self.photoPicker.sourceType = .photoLibrary
                    self.photoPicker.mediaTypes = UIImagePickerController.availableMediaTypes(for: .photoLibrary)!
                    self.photoPicker.modalPresentationStyle = .popover
                    self.present(self.photoPicker, animated: true, completion: nil)
                    
                }
                
                let cancelAction = UIAlertAction(title: "Cancel", style: .cancel) { (action) in
                }
                
                alertController.addAction(searchAction)
                alertController.addAction(cancelAction)
                
                self.present(alertController, animated: true, completion: nil)
                
                
                print(newItem)
                // reload the table with added row
                // this happens before getting the image, so first we add the row
                // without the image and then add the image
                self.locationTableView.reloadData()
            }
        }
        
        let cancelAction1 = UIAlertAction(title: "Cancel", style: .cancel) { (action) in
        }
        
        alert2.addTextField { (textField) in
            textField.placeholder = "City Name"
        }
        alert2.addTextField { (textField) in
            textField.placeholder = "Address"
        }
        
        alert2.addAction(searchAction1)
        alert2.addAction(cancelAction1)
        
        self.present(alert2, animated: true, completion: nil)
    }
    
    
    
    @IBAction func deletePlaces(_ sender: Any) {
        let alertController = UIAlertController(title: "Delete All Places?", message: "", preferredStyle: .alert)
        
        let serachAction = UIAlertAction(title: "Yes", style: .default) { [self] (aciton) in
            self.m?.deleteAll(view: locationTableView)
        }
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel) { (action) in
        }
        
        alertController.addAction(serachAction)
        alertController.addAction(cancelAction)
        
        self.present(alertController, animated: true, completion: nil)
    }
    
    func updateLastRow() {
        let indexPath = IndexPath(row: (m?.fetchedResults.count)! - 1, section: 0)
        locationTableView.reloadRows(at: [indexPath], with: .automatic)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let city = m?.fetchedResults.last, let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            city.picture = image.pngData()! as NSData
            do {
                try managedObjectContext.save()
            } catch {
                print("Error while saving the new image")
            }
            //update the row with image
            updateLastRow()
            
        }
        picker .dismiss(animated: true, completion: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let selectedIndex:IndexPath = self.locationTableView.indexPath(for: sender as! UITableViewCell)!
        
        let city = m?.getCity(item: selectedIndex.row)
        selectedCity = city
        
        if (segue.identifier == "secondSegue") {
            if let viewController: SecondViewController = segue.destination as? SecondViewController{
                viewController.photo = UIImage(data: (city?.picture)! as Data)
                viewController.address = city?.address
            }
        }
    }
    
    @IBAction func fromSecond(segue: UIStoryboardSegue, sender: Any?){

        if let des:SecondViewController = segue.source as? SecondViewController{
            let data = des.placeImage.image
            let data2 = des.address
           
            selectedCity!.picture = data?.pngData() as! NSData
            selectedCity?.address = data2
            do {
                try managedObjectContext.save()
            } catch {
                print("Error while saving the new image")
            }
            locationTableView.reloadData()
        }
    }
    
}

