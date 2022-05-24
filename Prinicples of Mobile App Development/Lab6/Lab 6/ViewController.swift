//
//  ViewController.swift
//  Lab4
//
//  Created by Eduardo Teodosio on 2/28/22.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var myCitiesList:Cities = Cities()
    
    @IBOutlet weak var cityTable: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    //  Set the row height for the first (zeroth) cell in all section(s) to 100, and set all other cells to 50.
    //  You can also set the row height for all cells in a section by accessing indexPath.section.
        return 161
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return myCitiesList.getCount()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cityCell", for: indexPath) as! CityTableViewCell
        cell.layer.borderWidth = 1.0
        
        let cityItem = myCitiesList.getFruitObject(item: indexPath.row)
        
        cell.cellCityName.text = cityItem.cityName!
        cell.cellCityDescription.text = cityItem.cityDescription!
        cell.cellCityImage.image = UIImage(named: cityItem.cityImageName!)
        
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        return UITableViewCell.EditingStyle.delete
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        myCitiesList.removeFruitObject(item: indexPath.row)
        
        self.cityTable.beginUpdates()
        self.cityTable.deleteRows(at: [indexPath], with: .automatic)
        self.cityTable.endUpdates()
    }

    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let selectedIndex:IndexPath = self.cityTable.indexPath(for: sender as! UITableViewCell)!
        
        let city = myCitiesList.getFruitObject(item: selectedIndex.row)
        
        if (segue.identifier == "detailView") {
            if let viewController: DetailViewController = segue.destination as? DetailViewController{
                viewController.selectedCity = city.cityName
                viewController.selectedDescription = city.cityDescription
            }
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    
    @IBAction func addPlace(_ sender: Any) {
        let alert = UIAlertController(title: "Add A Place", message: nil, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        
        alert.addTextField(configurationHandler: { textField in
            textField.placeholder = "Enter Name of the Place Here"
        })
        
        alert.addTextField(configurationHandler: { textField in
            textField.placeholder = "Enter Address"
        })
        
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { action in
            
            let secondTextField = alert.textFields![1] as UITextField
            
            // Do this first, then use method 1 or method 2
            if let name = alert.textFields?.first?.text, let y =  secondTextField.text  {
                print("city name: \(name)")
                

                
               // let f4 = fruit(fn: name, fd: "Healthy", fin: "banana.jpg")
                
                self.myCitiesList.addFruitObject(name: name, desc: y, image: "Tempe.jpeg")
                
                //Method 1
               
                let indexPath = IndexPath (row: self.myCitiesList.getCount() - 1, section: 0)
                self.cityTable.beginUpdates()
                self.cityTable.insertRows(at: [indexPath], with: .automatic)
                self.cityTable.endUpdates()
                
               //Method 2
                //self.fruitTable.reloadData()
            }
        }))
        
        self.present(alert, animated: true)
        
    }
    
    
    @IBAction func deleteAll(_ sender: Any) {
        let alertController = UIAlertController(title: "Delete All Places?", message: "", preferredStyle: .alert)
        
        let serachAction = UIAlertAction(title: "Yes", style: .default) { [self] (aciton) in
            self.myCitiesList.removeAll()
            cityTable.reloadData();
        }
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel) { (action) in
        }
        
        alertController.addAction(serachAction)
        alertController.addAction(cancelAction)
        
        self.present(alertController, animated: true, completion: nil)
    }
    
    
    
}

