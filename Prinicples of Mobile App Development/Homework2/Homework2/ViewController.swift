//
//  ViewController.swift
//  Homework2
//
//  Created by Eduardo Teodosio on 4/19/22.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UIImagePickerControllerDelegate & UINavigationControllerDelegate {

    var myCitiesList:Cities = Cities()
    let SectionTitles = ["A", "B", "C", "D", "E", "F", "G", "H", "I", "J", "K", "L", "M", "N", "O", "P", "Q", "R", "S", "T", "U", "V", "W", "X", "Y", "Z"]

    @IBOutlet weak var cityTable: UITableView!
    let picker = UIImagePickerController()
    var addedCity:city?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        picker.delegate = self
        // Do any additional setup after loading the view.
        myCitiesList.createCityDictionary()
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        SectionTitles.count
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return self.SectionTitles[section]
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 108
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //return myCitiesList.getCount()
        // Return the number of rows in the section.
       // get the section title
       let fruitKey = SectionTitles[section]
    
       // use the section title to count how many fruits are in that se
      if let count = myCitiesList.getSectionCount(key: fruitKey)
      {
        return count
       }else
      {
        return 0;
      }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cityCell", for: indexPath) as! CityTableViewCell
        cell.layer.borderWidth = 1.0
        let cityKey = SectionTitles[indexPath.section]
        
        if let city = myCitiesList.getCityObjectforRow(key: cityKey, index: indexPath.row){
            
            //let cityItem = myCitiesList.getFruitObject(item: indexPath.row)
            
            cell.cityName.text = city.cityName!
            cell.cityImage.image = city.cityImageName
        }
        
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        return UITableViewCell.EditingStyle.delete
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        let cityKey = SectionTitles[indexPath.section]
        let city = myCitiesList.getCityObjectforRow(key: cityKey, index: indexPath.row)
        myCitiesList.removeFruitObject(item: (city?.cityName)!)
        
//        self.cityTable.beginUpdates()
//        self.cityTable.deleteRows(at: [indexPath], with: .automatic)
//        self.cityTable.endUpdates()
        cityTable.reloadData()
    }
    
    @IBAction func addCity(_ sender: Any) {
        let alert2 = UIAlertController(title: "Add A City", message: "", preferredStyle: .alert)
        
        let searchAction1 = UIAlertAction(title: "Ok", style: .default) { [self] (aciton) in
            
            let firstTextField = alert2.textFields![0] as UITextField
            let secondTextField = alert2.textFields![1] as UITextField
            
            addedCity = self.myCitiesList.addFruitObject(name: firstTextField.text!, desc: secondTextField.text!, image: UIImage(named:"Tempe.jpeg")!)
            
            if let x = firstTextField.text, let y =  secondTextField.text {
                print(firstTextField.text!)
                print(secondTextField.text!)

                
                // show the alert controller to select an image for the row
                let alertController = UIAlertController(title: "Add City Picture?", message: "", preferredStyle: .alert)
                self.cityTable.reloadData()
                
                let searchAction = UIAlertAction(title: "Select Picture", style: .default) { [self] (aciton) in
                    // load image
                    picker.allowsEditing = false
                    picker.sourceType = .photoLibrary
                    picker.mediaTypes = UIImagePickerController.availableMediaTypes(for: .photoLibrary)!
                    picker.modalPresentationStyle = .popover
                    present(picker, animated: true, completion: nil)
                    
                }
                
                let cancelAction = UIAlertAction(title: "Cancel", style: .cancel) { (action) in
                }
                
                alertController.addAction(searchAction)
                alertController.addAction(cancelAction)
                
                self.present(alertController, animated: true, completion: nil)

                // reload the table with added row
                // this happens before getting the image, so first we add the row
                // without the image and then add the image
                //myCitiesList.createCityDictionary()
                //self.cityTable.reloadData()
                reloadTable()
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
    
    func reloadTable(){
        cityTable.reloadData()
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let selectedIndex:IndexPath = self.cityTable.indexPath(for: sender as! UITableViewCell)!
        
        let cityKey = SectionTitles[selectedIndex.section]
        
        let city = myCitiesList.getCityObjectforRow(key: cityKey, index: selectedIndex.row)
        
        if (segue.identifier == "detailView") {
            if let viewController: DetailViewController = segue.destination as? DetailViewController{
                viewController.selectedCity = city!.cityName
                viewController.selectedDescription = city!.cityDescription
                viewController.photo = city!.cityImageName
            }
        }
    }
    
    @IBAction func fromSecond(segue: UIStoryboardSegue, sender: Any?){
        
        if let des:DetailViewController = segue.source as? DetailViewController{
            let data = des.selectedImage.image
            let name = des.name.text
            let desc = des.desc.text
            
            myCitiesList.changeImage(c: name!, image: data!)
            myCitiesList.changeDescription(c: name!, desc: desc!)
            cityTable.reloadData()
        }
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        picker .dismiss(animated: true, completion: nil)

        // fetch resultset has the recently added row without the image
        // this code ad the image to the row
        let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage
        
        myCitiesList.changeImage(c: (addedCity?.cityName!)!, image: image!)
        reloadTable()
    }
}

