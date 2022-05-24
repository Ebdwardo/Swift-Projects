//
//  SecondViewController.swift
//  ClassProject
//
//  Created by Eduardo Teodosio on 3/20/22.
//

import UIKit
import MapKit

class SecondViewController: UIViewController, MKMapViewDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    @IBOutlet weak var scrolling: UIScrollView!
    
    var photo = UIImage(named: "tempe.jpeg")
    var address:String?
    var longitude:Float32?
    var latitude:Float32?
    var baseCity:String?
    
    var info:[information]?
    
    struct leisure_information:Decodable{
        let type:String?
        let features:[information]
    }
    
    struct information: Decodable{
        let type: String?
        let properties:prop
        let geometry:geom
    }
    
    struct prop:Decodable{
        let name:String?
        let county:String?
        let city:String?
        let state:String?
        let country:String?
        let country_code:String?
        let lon:Float32?
        let lat:Float32?
        let formatted:String?
        let address_line1:String?
        let address_line2:String?
        let categories:[String]?
        let details:[String]?
        let datasource:dataSource?
        let place_id:String?
    }
    
    struct dataSource:Decodable{
        let sourcename:String?
        let attribution:String?
        let license:String?
        let url:String?
    }
    
    struct geom:Decodable{
        let type: String?
        let coordinates:[Float32]?
    }
    
    @IBOutlet weak var placeImage: UIImageView!
    @IBOutlet weak var imageSource: UISegmentedControl!
    @IBOutlet weak var resultsView: UITextView!
    
    @IBOutlet weak var mapType: UISegmentedControl!
    let picker = UIImagePickerController()

    @IBOutlet weak var map: MKMapView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.resultsView.text.append("Search Results Go Here")
        picker.delegate = self
        placeImage.image = photo
        
        _ = CLGeocoder()
        let address = address
        CLGeocoder().geocodeAddressString(address!, completionHandler: { [self](placemarks, error) in
            
            if error != nil{
                print("Geocode Failed: \(error!.localizedDescription)")
                resultsView.textAlignment = NSTextAlignment.center
                resultsView.text = "Place not found"
                
                // display the map
                let lon : CLLocationDegrees = -112.06
                
                let lat : CLLocationDegrees = 33.45
                
                let coordinates = CLLocationCoordinate2D( latitude: lat, longitude: lon)
                let span: MKCoordinateSpan = MKCoordinateSpan.init(latitudeDelta: 0.01, longitudeDelta: 0.01)
                
                let region: MKCoordinateRegion = MKCoordinateRegion.init(center: coordinates, span: span)
                
                self.map.setRegion(region, animated: true)
                
                // add an annotation
                let annotation = MKPointAnnotation()
                annotation.coordinate = coordinates
                annotation.title = "Phoenix"
                annotation.subtitle = "AZ"
                
                self.map.addAnnotation(annotation)
            }
            else if placemarks!.count > 0{
                let placemark = placemarks![0]
                let location = placemark.location
                let coords = location!.coordinate
                self.longitude = Float32(coords.longitude)
                self.latitude = Float32(coords.latitude)
                print(self.latitude!)
                print(self.longitude!)
                
                let coordinates = CLLocationCoordinate2D(latitude: coords.latitude, longitude: coords.longitude)
                let span: MKCoordinateSpan = MKCoordinateSpan.init(latitudeDelta: 0.06, longitudeDelta: 0.06)
                let region: MKCoordinateRegion = MKCoordinateRegion.init(center: coordinates, span: span)
                self.map.setRegion(region, animated: true)
                let annotation = MKPointAnnotation()
                annotation.coordinate = coordinates
                annotation.title = placemark.name
                baseCity = placemark.locality
                annotation.subtitle = placemark.locality
                
                self.map.addAnnotation(annotation)
                
                let urlAsString = "https://api.geoapify.com/v2/places?categories=leisure&filter=rect:\(longitude!-0.06),\(latitude!-0.06),\(longitude!+0.06),\(latitude!+0.06)&limit=50&apiKey=9316bca2931548aba377381147c9de8f"
                
                
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

        let jsonQuery = urlses.dataTask(with: string, completionHandler: { [self] data, response, error -> Void in
            if (error != nil) {
                print(error!.localizedDescription)
                DispatchQueue.main.async{
                    self.resultsView.textAlignment = NSTextAlignment.center
                    self.resultsView.text.append(error!.localizedDescription)
                }
            }
            var err: NSError?

            let decoder = JSONDecoder()
            let jsonResult = try! decoder.decode(leisure_information.self, from: data!)

            if (err != nil) {
                print("JSON Error \(err!.localizedDescription)")
            }

           // print(jsonResult)


            self.info = jsonResult.features
            

        })

        jsonQuery.resume()
    }
    
    @IBAction func showMap(_ sender: UISegmentedControl){
        switch(mapType.selectedSegmentIndex)
        {
        case 0:
            map.mapType = MKMapType.standard
        
        case 1:
           map.mapType = MKMapType.satellite
        
        case 2:
           map.mapType = MKMapType.hybrid
            
        default:
            map.mapType = MKMapType.standard
        }
        
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
    
    @IBAction func changeAddress(_ sender: UIButton) {
        let alert2 = UIAlertController(title: "Add A Place", message: "", preferredStyle: .alert)
        
        let searchAction1 = UIAlertAction(title: "Ok", style: .default) { [self] (aciton) in
            
            let firstTextField = alert2.textFields![0] as UITextField
            
            if let x = firstTextField.text{
                print(x)
                address = x
                viewDidLoad()
            }
        }
        
        let cancelAction1 = UIAlertAction(title: "Cancel", style: .cancel) { (action) in
        }
        
        alert2.addTextField { (textField) in
            textField.placeholder = "New Address"
        }
        
        alert2.addAction(searchAction1)
        alert2.addAction(cancelAction1)
        
        self.present(alert2, animated: true, completion: nil)
    }
    
    @IBAction func listSpots(_ sender: Any) {
        self.resultsView.text = ""
        var counter = 1
        if info != nil{
            for items in info!{
                DispatchQueue.main.async {
                    if items.properties.name != nil && items.properties.name != items.properties.city{
                        self.resultsView.text.append("\(counter): " + items.properties.formatted! + "\n")
                        
                        let lat = CLLocationDegrees(items.properties.lat!)
                        let lon = CLLocationDegrees(items.properties.lon!)
                        let coordinates = CLLocationCoordinate2D(latitude: lat, longitude: lon)
                        let span: MKCoordinateSpan = MKCoordinateSpan.init(latitudeDelta: 0.06, longitudeDelta: 0.06)
                        let region: MKCoordinateRegion = MKCoordinateRegion.init(center: coordinates, span: span)
                        self.map.setRegion(region, animated: true)
                        let annotation = MKPointAnnotation()
                        annotation.coordinate = coordinates
                        annotation.title = items.properties.name
                        annotation.subtitle = items.properties.city
                        
                        self.map.addAnnotation(annotation)
                        
                        counter += 1
                    }
                }

            }
        }else{
            self.resultsView.text = "Enter a valid Address"
        }
    
    }
    
    @IBAction func resetMap(_ sender: UIButton) {
        for p in map.overlays{
            map.removeOverlay(p)
        }
        if self.latitude != nil && self.longitude != nil && self.baseCity != ""{
            
            var l = CLLocationDegrees(self.latitude!)
            var lon = CLLocationDegrees(self.longitude!)
            
            let coordinates = CLLocationCoordinate2D(latitude: l, longitude: lon)
            let span: MKCoordinateSpan = MKCoordinateSpan.init(latitudeDelta: 0.06, longitudeDelta: 0.06)
            let region: MKCoordinateRegion = MKCoordinateRegion.init(center: coordinates, span: span)
            self.map.setRegion(region, animated: true)
            let annotation = MKPointAnnotation()
            annotation.coordinate = coordinates
            annotation.title = address
            annotation.subtitle = baseCity
        }
        else{
            resultsView.text = "Enter a Valid Address"
        }
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        picker .dismiss(animated: true, completion: nil)

        // fetch resultset has the recently added row without the image
        // this code ad the image to the row
        let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage
        
        placeImage.image = image
    }
    
    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
        print(view.tag)
        
        var l = CLLocationDegrees(self.latitude!)
        var lon = CLLocationDegrees(self.longitude!)
        let request = MKDirections.Request()
               request.source = MKMapItem(placemark: MKPlacemark(coordinate: CLLocationCoordinate2D(latitude: l, longitude: lon), addressDictionary: nil))
        request.destination = MKMapItem(placemark: MKPlacemark(coordinate: CLLocationCoordinate2D(latitude: view.annotation!.coordinate.latitude, longitude: view.annotation!.coordinate.longitude), addressDictionary: nil))
               request.requestsAlternateRoutes = true
               request.transportType = .automobile

               let directions = MKDirections(request: request)

               directions.calculate { [unowned self] response, error in
                   guard let unwrappedResponse = response else { return }

                   for route in unwrappedResponse.routes {
                       self.map.addOverlay(route.polyline)
                       self.map.setVisibleMapRect(route.polyline.boundingMapRect, animated: true)
                   }
               }
    }
    
    
    func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
            let renderer = MKPolylineRenderer(polyline: overlay as! MKPolyline)
            renderer.strokeColor = UIColor.blue
            return renderer
        }

}
