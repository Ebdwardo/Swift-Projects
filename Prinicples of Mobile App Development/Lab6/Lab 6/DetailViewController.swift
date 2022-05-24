//
//  DetailViewController.swift
//  Lab4
//
//  Created by Eduardo Teodosio on 2/28/22.
//

import UIKit
import MapKit

class DetailViewController: UIViewController, MKMapViewDelegate {

    var selectedCity:String?
    var selectedDescription:String?
    
    @IBOutlet weak var mapChoice: UISegmentedControl!
    
    @IBOutlet weak var searchQuery: UITextField!
    @IBOutlet weak var longitude: UITextField!
    @IBOutlet weak var latitude: UITextField!
    @IBOutlet weak var map: MKMapView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadMap()
    }
   
    @IBAction func showMap(_ sender: UISegmentedControl) {
        switch(mapChoice.selectedSegmentIndex){
        case 0:
            map.mapType = MKMapType.standard
        case 1:
            map.mapType = MKMapType.satellite
        case 2:
            map.mapType = MKMapType.hybrid
        default:
            map.mapType = MKMapType.standard
        }
        
        loadMap()
    }
    
    @IBAction func search(_ sender: UIButton) {
        let request = MKLocalSearch.Request()
        request.naturalLanguageQuery = self.searchQuery.text
        request.region = map.region
        let search = MKLocalSearch(request: request)
        
        search.start {
            response, _ in
            guard let response = response else{
                return
            }
            
            print(response.mapItems)
            var matchingItems:[MKMapItem] = []
            matchingItems = response.mapItems
            for i in 1...matchingItems.count - 1 {
                let place = matchingItems[i].placemark
                print(place.location?.coordinate.latitude)
                print(place.location?.coordinate.longitude)
                print(place.name)
                
                let ani = MKPointAnnotation()
                ani.coordinate = place.location!.coordinate
                ani.title = place.name 
                ani.subtitle = place.subLocality
                
                self.map.addAnnotation(ani)
            }
        }
    }
    
    func loadMap(){
        let geoCoder = CLGeocoder()
        let address = selectedDescription!
        CLGeocoder().geocodeAddressString(address, completionHandler: {(placemarks, error) in
            
            if error != nil{
                print("Geocode Failed: \(error!.localizedDescription)")
            }
            else if placemarks!.count > 0{
                let placemark = placemarks![0]
                let location = placemark.location
                let coords = location!.coordinate
                print(location)
                
                let span = MKCoordinateSpan.init(latitudeDelta: 0.05, longitudeDelta: 0.05)
                let region = MKCoordinateRegion(center: placemark.location!.coordinate, span: span)
                self.map.setRegion(region, animated: true)
                let ani = MKPointAnnotation()
                ani.coordinate = placemark.location!.coordinate
                ani.title = self.selectedCity
                ani.subtitle = placemark.subLocality
                
                self.map.addAnnotation(ani)
                
                self.longitude.text = placemark.location!.coordinate.longitude.description
                
                self.latitude.text = placemark.location!.coordinate.latitude.description
            }
        })
    }
}
