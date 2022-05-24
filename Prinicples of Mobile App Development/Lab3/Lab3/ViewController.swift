//
//  ViewController.swift
//  Lab3
//
//  Created by Eduardo Teodosio on 2/14/22.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var titleInput: UITextField!
    @IBOutlet weak var genreInput: UITextField!
    @IBOutlet weak var ticketSaleInput: UITextField!
    
    @IBOutlet weak var titleResult: UITextField!
    @IBOutlet weak var genreResult: UITextField!
    @IBOutlet weak var ticketSaleResults: UITextField!
    
    var movieInfoDictionary:infoDictionary = infoDictionary()
    
    var index = 0
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }


    @IBAction func addRec(_ sender: UIBarButtonItem) {
        // check if input fields are empty
        let title = titleInput.text!, genre = genreInput.text!, ticketsale = Double(ticketSaleInput.text!)
        if (!title.isEmpty && !genre.isEmpty && !ticketSaleInput.text!.isEmpty)
            {
            // create a person record
            //let pRecord =  personRecord(n: name, s:ssn, a: age)
            
            movieInfoDictionary.add(title,genre,ticketsale!)
            
            // remove data from the text fields
            self.titleInput.text = ""
            self.genreInput.text = ""
            self.ticketSaleInput.text = ""
            
            }else
            {
               // Alert message will be displayed to th user if there is no input
               let alert = UIAlertController(title: "Data Input Error", message: "Data Inputs are either empty or incorrect types", preferredStyle: .alert)
                
                alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
                self.present(alert, animated: true)
                
            }
    }
    

    @IBAction func deleteMovie(_ sender: UIBarButtonItem) {
        let alert1 = UIAlertController(title: "Delete Movie", message: "", preferredStyle: .alert)
        
        let dataInputAction = UIAlertAction(title: "Ok", style: .default) { (aciton) in
            
            let textField = alert1.textFields![0] as UITextField
            
            if let x = textField.text{
                self.movieInfoDictionary.deleteRec(s: x)
                self.titleResult.text = ""
                self.genreResult.text = ""
                self.ticketSaleResults.text = ""
                self.index = 0
                let alert = UIAlertController(title: "Movie Deleted", message: "Movie was found and deleted", preferredStyle: .alert)
                 
                 alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
                 self.present(alert, animated: true)
            }
        }
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .default) { (aciton) in
            
        }
        
        alert1.addTextField { (textField) in
            textField.placeholder = "Title"
        }
        
        
        alert1.addAction(dataInputAction)
        alert1.addAction(cancelAction)
        
        self.present(alert1, animated: true, completion: nil)
    }
    

    @IBAction func searchMovie(_ sender: UIBarButtonItem) {
        let alert1 = UIAlertController(title: "Search for a Movie", message: "", preferredStyle: .alert)
        
        let dataInputAction = UIAlertAction(title: "Ok", style: .default) { (aciton) in
            
            let textField = alert1.textFields![0] as UITextField
            
            
            if let x = textField.text{
                let y = self.movieInfoDictionary.search(s: x)
                if y != nil {
                    self.index = self.movieInfoDictionary.num-1
                    self.titleResult.text = y?.title
                    self.genreResult.text = y?.genre
                    self.ticketSaleResults.text = "\(String(describing: y!.ticketSale!))"
                }
                else{
                    self.titleResult.text = ""
                    self.genreResult.text = ""
                    self.ticketSaleResults.text = ""
                    let alert = UIAlertController(title: "Movie Not Found", message: "No Movie with that Name was Found", preferredStyle: .alert)
                     
                     alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
                     self.present(alert, animated: true)
                }
            }
        }
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .default) { (aciton) in
            
        }
        
        alert1.addTextField { (textField) in
            textField.placeholder = "name"
        }
        
        
        alert1.addAction(dataInputAction)
        alert1.addAction(cancelAction)
        
        self.present(alert1, animated: true, completion: nil)
    }
    
    @IBAction func previousRecord(_ sender: UIBarButtonItem) {
        if index == -1{
            index += 1
            let keys = Array(movieInfoDictionary.infoRepository.keys)
            let keyIndex = keys[index]
            let keyResults = movieInfoDictionary.infoRepository[keyIndex]
            
            titleResult.text = keyResults?.title
            genreResult.text = keyResults?.genre
            ticketSaleResults.text = "\(String(describing: keyResults!.ticketSale!))"
            let alert = UIAlertController(title: "Showing the First Movie", message: "", preferredStyle: .alert)
             
             alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
             self.present(alert, animated: true)
        }
        else{
            index -= 1
            let keys = Array(movieInfoDictionary.infoRepository.keys)
            if index == -1 && !movieInfoDictionary.infoRepository.isEmpty{
                index += 1
                let keyIndex = keys[index]
                let keyResults = movieInfoDictionary.infoRepository[keyIndex]
                
                titleResult.text = keyResults?.title
                genreResult.text = keyResults?.genre
                ticketSaleResults.text = "\(String(describing: keyResults!.ticketSale!))"
                let alert = UIAlertController(title: "Showing the First Movie", message: "", preferredStyle: .alert)
                 
                 alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
                 self.present(alert, animated: true)
            }
            else if index >= 0 && !movieInfoDictionary.infoRepository.isEmpty{
                let keyIndex = keys[index]
                let keyResults = movieInfoDictionary.infoRepository[keyIndex]
                
                titleResult.text = keyResults?.title
                genreResult.text = keyResults?.genre
                ticketSaleResults.text = "\(String(describing: keyResults!.ticketSale!))"
            }
            else{
                index += 1
            }
        }
        
    }
    
    @IBAction func nextRecord(_ sender: UIBarButtonItem) {
        index += 1
        let keys = Array(movieInfoDictionary.infoRepository.keys)
        if index == keys.count && !movieInfoDictionary.infoRepository.isEmpty{
            index -= 1
            let keyIndex = keys[index]
            let keyResults = movieInfoDictionary.infoRepository[keyIndex]
            
            titleResult.text = keyResults?.title
            genreResult.text = keyResults?.genre
            ticketSaleResults.text = "\(keyResults!.ticketSale!)"
            let alert = UIAlertController(title: "No More Movies", message: "", preferredStyle: .alert)
             
             alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
             self.present(alert, animated: true)
        }
        else if keys.count > index && !movieInfoDictionary.infoRepository.isEmpty
        {
            let keyIndex = keys[index]
            let keyResults = movieInfoDictionary.infoRepository[keyIndex]
            
            titleResult.text = keyResults?.title
            genreResult.text = keyResults?.genre
            ticketSaleResults.text = "\(String(describing: keyResults!.ticketSale!))"
        }
        else{
            index -= 1
        }
        
    }
    
    @IBAction func editMovie(_ sender: UIBarButtonItem) {
        let alert2 = UIAlertController(title: "Edit Movie Price", message: "", preferredStyle: .alert)
        
        let editAction = UIAlertAction(title: "Ok", style: .default) { (aciton) in
            
            let firstTextField = alert2.textFields![0] as UITextField
            let secondTextField = alert2.textFields![1] as UITextField
            
            if let x = firstTextField.text, let y =  Double(secondTextField.text!) {
                print(firstTextField.text!)
                print(secondTextField.text!)
                self.movieInfoDictionary.infoRepository[x]?.ticketSale = y
                self.titleResult.text = ""
                self.genreResult.text = ""
                self.ticketSaleResults.text = ""
                self.index = -1
                let alert = UIAlertController(title: "Price Changed", message: "", preferredStyle: .alert)
                 
                 alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
                 self.present(alert, animated: true)
                
            }
        }
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel) { (action) in
        }
        
        alert2.addTextField { (textField) in
            textField.placeholder = "Title"
        }
        
        alert2.addTextField { (textField) in
            textField.placeholder = "Ticket Sale"
            textField.keyboardType = .decimalPad
        }
        
        alert2.addAction(editAction)
        alert2.addAction(cancelAction)
        
        self.present(alert2, animated: true, completion: nil)

    }
    
}

