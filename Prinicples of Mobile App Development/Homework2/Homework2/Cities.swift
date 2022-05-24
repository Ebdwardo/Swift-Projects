//
//  Cities.swift
//  Homework2
//
//  Created by Eduardo Teodosio on 4/19/22.
//

import Foundation
import UIKit
class Cities
{
    var cities:[city] = []
    var cityList = [String:[city]]()
    
    init()
    {
        let f1 = city(fn: "Tempe", fd: "Tempe is a city just east of Phoenix, in Arizona.", fin: UIImage(named: "Tempe.jpeg")!)
        let f2 = city(fn: "Kingman", fd: "Kingman is a city along Route 66, in northwestern Arizona.", fin: UIImage(named:"Kingman.jpeg")!)
        let f3 = city(fn: "Bullhead City", fd: "Bullhead City is a city located on the Colorado River in Mohave County, Arizona", fin: UIImage(named:"Bullhead City.jpeg")!)
        let f4 = city(fn: "Laughlin", fd: "Laughlin is an unincorporated resort town and census-designated place in Clark County, Nevada, United States", fin: UIImage(named:"Laughlin.jpeg")!)
        let f5 = city(fn: "Las Vegas", fd: "Las Vegas, often known simply as Vegas, is the 26th-most populous city in the United States", fin: UIImage(named:"Las Vegas.jpeg")!)
        
        cities.append(f1)
        cities.append(f2)
        cities.append(f3)
        cities.append(f4)
        cities.append(f5)

    }
    
    func changeImage(c: String, image: UIImage){
        for i in cities{
            if i.cityName == c{
                i.cityImageName = image
                break
            }
        }
        
        cityList.removeAll()
        createCityDictionary()
    }
    
    func changeDescription(c:String, desc:String){
        for i in cities{
            if i.cityName == c{
                i.cityDescription = desc
                break
            }
        }
        
        cityList.removeAll()
        createCityDictionary()
    }
    
    func createCityDictionary() {
           // for each fruit in the fruit list from the fruits object
           for city in cities {
             
               // extract the first letter as a string for the key
               let fName = city.cityName
               
               let endIndex = fName!.index((fName!.startIndex), offsetBy: 1)
               
               let cityKey = String(fName![(..<endIndex)]).uppercased()
               
               // build the fruit object array for each key
                if var cityObjects = cityList[cityKey] {
                cityObjects.append(city)
                cityList[cityKey] = cityObjects
                
                } else {
                    cityList[cityKey] = [city]
                }
    
           }
    }
    
    func getSectionCount(key : String) -> Int?
    {
        return cityList[key]?.count
    }
    
    func getCityObjectforRow(key:String, index: Int) -> city?
    {
        if let cityValues = cityList[key]{
           return cityValues[index];
        }else
        {
            return nil
        }
        
    }
    
    func getCount() -> Int
    {
        return cities.count
    }
    
    func getFruitObject(item:Int) -> city{
        
        return cities[item]
    }
    
    func removeFruitObject(item:String) {
        var counter = 0
        
        for i in cities{
            if i.cityName == item{
                cities.remove(at: counter)
                break
            }
            counter+=1
        }
        
        cityList.removeAll()
        createCityDictionary()
    }
    
    func addFruitObject(name:String, desc: String, image: UIImage) -> city{
        let f = city(fn: name, fd: desc, fin: image)
        cities.append(f)
        // extract the first letter as a string for the key
        cityList.removeAll()
        createCityDictionary()
        return f
    }
    
}
class city
{
    var cityName:String?
    var cityDescription:String?
    var cityImageName:UIImage?
    
    init(fn:String, fd:String, fin:UIImage)
    {
        cityName = fn
        cityDescription = fd
        cityImageName = fin
        
    }
    
    
}
