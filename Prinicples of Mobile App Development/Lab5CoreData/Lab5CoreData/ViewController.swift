//
//  ViewController.swift
//  Lab5CoreData
//
//  Created by Eduardo Teodosio on 3/11/22.
//

import UIKit
import CoreData

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UIImagePickerControllerDelegate & UINavigationControllerDelegate  {
    
    var selectedCity:City?
    
    @IBOutlet weak var cityTableView: UITableView!
    let managedObjectContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    var m:Cities?
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return m!.fetchRecord()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // add each row from coredata fetch results
        let cell = tableView.dequeueReusableCell(withIdentifier: "cityCell", for: indexPath) as! CityTableViewCell
        
        let cityItem = m?.fetchedResults[indexPath.row]
        //cell.layer.borderWidth = 1.0
        //cityTableView.rowHeight = UITableView.automaticDimension

        
        cell.cityName.text = cityItem?.name
        //cell.cityDescription.text = cityItem?.cityDescription
        cell.cellCityImage.image = UIImage(data: (cityItem?.picture)! as Data)
        
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
            cityTableView.reloadData()
        }
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    //  Set the row height for the first (zeroth) cell in all section(s) to 100, and set all other cells to 50.
    //  You can also set the row height for all cells in a section by accessing indexPath.section.
        return 200
        
    }
    
 
    @IBAction func addCity(_ sender: UIBarButtonItem) {

        
        let alert2 = UIAlertController(title: "Add A City", message: "", preferredStyle: .alert)
        
        let searchAction1 = UIAlertAction(title: "Ok", style: .default) { (aciton) in
            
            let firstTextField = alert2.textFields![0] as UITextField
            let secondTextField = alert2.textFields![1] as UITextField
            
            if let x = firstTextField.text, let y =  secondTextField.text {
                print(firstTextField.text)
                print(secondTextField.text)
                
                
                // create a new entity object
                let ent = NSEntityDescription.entity(forEntityName: "City", in: self.managedObjectContext)
                //add to the manege object context
                let newItem = City(entity: ent!, insertInto: self.managedObjectContext)
                newItem.name = x
                newItem.cityDescription = y
                let image = UIImage(named: "tempe.jpeg")
                newItem.picture = image?.pngData() as NSData?
                
                // show the alert controller to select an image for the row
                let alertController = UIAlertController(title: "Add City Picture?", message: "", preferredStyle: .alert)
                
                let searchAction = UIAlertAction(title: "Picture", style: .default) { (aciton) in
                    // load image
                    let photoPicker = UIImagePickerController ()
                    photoPicker.delegate = self
                    photoPicker.sourceType = .photoLibrary
                    // display image selection view
                    self.present(photoPicker, animated: true, completion: nil)
                    
                }
                
                let cancelAction = UIAlertAction(title: "Cancel", style: .cancel) { (action) in
                }
                
                alertController.addAction(searchAction)
                alertController.addAction(cancelAction)
                
                self.present(alertController, animated: true, completion: nil)
                
                // save the updated context
                do {
                    try self.managedObjectContext.save()
                } catch _ {
                }
                
                
                print(newItem)
                // reload the table with added row
                // this happens before getting the image, so first we add the row
                // without the image and then add the image
                self.cityTableView.reloadData()
            }
        }
        
        let cancelAction1 = UIAlertAction(title: "Cancel", style: .cancel) { (action) in
        }
        
        alert2.addTextField { (textField) in
            textField.placeholder = "City Name"
        }
        
        alert2.addTextField { (textField) in
            textField.placeholder = "Description"
        }
        
        alert2.addAction(searchAction1)
        alert2.addAction(cancelAction1)
        
        self.present(alert2, animated: true, completion: nil)
       
    }
    
    
    @IBAction func deleteCity(_ sender: UIBarButtonItem) {
        let alertController = UIAlertController(title: "Delete All Cities?", message: "", preferredStyle: .alert)
        
        let serachAction = UIAlertAction(title: "Yes", style: .default) { [self] (aciton) in
            self.m?.deleteAll(view: cityTableView)
        }
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel) { (action) in
        }
        
        alertController.addAction(serachAction)
        alertController.addAction(cancelAction)
        
        self.present(alertController, animated: true, completion: nil)
        
        
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        m = Cities(context: managedObjectContext)
        
    }
    
    func updateLastRow() {
        let indexPath = IndexPath(row: (m?.fetchedResults.count)! - 1, section: 0)
        cityTableView.reloadRows(at: [indexPath], with: .automatic)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        picker .dismiss(animated: true, completion: nil)

        // fetch resultset has the recently added row without the image
        // this code ad the image to the row
        if let city = m?.fetchedResults.last, let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            city.picture = image.pngData()! as NSData
            //update the row with image
            updateLastRow()
            do {
                try managedObjectContext.save()
            } catch {
                print("Error while saving the new image")
            }
            
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let selectedIndex:IndexPath = self.cityTableView.indexPath(for: sender as! UITableViewCell)!
        
        let cityItem = m?.getCity(item: selectedIndex.row)
        selectedCity = cityItem!
        
        if (segue.identifier == "citySegue") {
            if let viewController: SecondViewController = segue.destination as? SecondViewController{
                viewController.cityImage = cityItem?.picture
                viewController.cityDescription = cityItem?.cityDescription
            }
        }
    }
    
    @IBAction func fromSecond(segue: UIStoryboardSegue, sender: Any?){
        
        if let des:SecondViewController = segue.source as? SecondViewController{
            let data = des.secondImage.image
           
            selectedCity!.picture = data?.pngData() as! NSData
            do {
                try managedObjectContext.save()
            } catch {
                print("Error while saving the new image")
            }
            cityTableView.reloadData()
        }
    }
    
}

