//
//  ViewController.swift
//  Lab7
//
//  Created by Eduardo Teodosio on 3/30/22.
//

import UIKit
import MapKit

class ViewController: UIViewController {
    
    @IBOutlet weak var cityTextField: UITextField!
    @IBOutlet weak var resultsView: UITextView!
    var longitude:Float32?
    var latitude:Float32?
    
    var earthquakesList:[information]?
    
    struct earthquake_information: Decodable{
        let earthquakes:[information]
    }
    
    struct information: Decodable{
        let datetime: String
        let depth: Float32
        let lng: Float32
        let src: String
        let eqid: String
        let magnitude: Float32
        let lat: Float32
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    @IBAction func buttonPress(_ sender: UIButton) {
        _ = CLGeocoder()
        let address = cityTextField.text!
        CLGeocoder().geocodeAddressString(address, completionHandler: { [self](placemarks, error) in
            
            if error != nil{
                print("Geocode Failed: \(error!.localizedDescription)")
                resultsView.textAlignment = NSTextAlignment.center
                resultsView.text = "Place not found"
            }
            else if placemarks!.count > 0{
                let placemark = placemarks![0]
                let location = placemark.location
                let coords = location!.coordinate
                self.longitude = Float32(coords.longitude)
                self.latitude = Float32(coords.latitude)
                print(self.latitude!)
                print(self.longitude!)
                
                let urlAsString = "http://api.geonames.org/earthquakesJSON?north=\(latitude!+10)&south=\(latitude!-10)&east=\(self.longitude!-10)&west=\(longitude!+10)&username=eduardo_teo"
                
                
                let url = URL(string: urlAsString)!
                let urlSession = URLSession.shared
                
                resultsView.text = ""

                
                DispatchQueue.main.async(execute: {
                    getJsonData(string: url, urlses: urlSession)
                })
                
            }
            
        })
        
 
    }
    
    
    
    

    
    func getJsonData(string: URL, urlses: URLSession){

        let jsonQuery = urlses.dataTask(with: string, completionHandler: { data, response, error -> Void in
            if (error != nil) {
                print(error!.localizedDescription)
                DispatchQueue.main.async{
                    self.resultsView.textAlignment = NSTextAlignment.center
                    self.resultsView.text.append(error!.localizedDescription)
                }
            }
            var err: NSError?

            let decoder = JSONDecoder()
            let jsonResult = try! decoder.decode(earthquake_information.self, from: data!)

            if (err != nil) {
                print("JSON Error \(err!.localizedDescription)")
            }

           // print(jsonResult)


            self.earthquakesList = jsonResult.earthquakes

            //print(self.earthquakesList);
            //print(self.earthquakesList?.count);
            
            if self.earthquakesList!.count > 10 {
                for i in 0...9
                {
                let y = self.earthquakesList?[i]
                    print(y!.datetime)
                    print(y!.magnitude)
                    
                    DispatchQueue.main.async{
                        self.resultsView.textAlignment = NSTextAlignment.left // remove from for loop for next time
                        self.resultsView.text.append("Date: " + y!.datetime + "\n")
                        self.resultsView.text.append(String("Magnitude: " + String(y!.magnitude) + "\n" + "\n"))
                    }
                }
            }
            else{
                
                for i in 0...(self.earthquakesList?.count)!-1
                {
                let y = self.earthquakesList?[i]
                    print(y!.datetime)
                    print(y!.magnitude)
                    
                    DispatchQueue.main.async{
                        self.resultsView.textAlignment = NSTextAlignment.left // remove from for loop for next time
                        self.resultsView.text.append("Date: " + y!.datetime + "\n")
                        self.resultsView.text.append(String("Magnitude: " + String(y!.magnitude) + "\n" + "\n"))
                    }
                }
                
            }
            
        })

        jsonQuery.resume()
    }

}
