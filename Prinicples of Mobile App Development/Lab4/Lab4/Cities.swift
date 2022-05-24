//
//  File.swift
//  Lab4
//
//  Created by Eduardo Teodosio on 2/28/22.
//

import Foundation

class Cities
{
    var cities:[city] = []
    
    init()
    {
        let f1 = city(fn: "Tempe", fd: "Tempe is a city just east of Phoenix, in Arizona.", fin: "Tempe.jpeg")
        let f2 = city(fn: "Kingman", fd: "Kingman is a city along Route 66, in northwestern Arizona.", fin: "Kingman.jpeg")
        let f3 = city(fn: "Bullhead City", fd: "Bullhead City is a city located on the Colorado River in Mohave County, Arizona", fin: "Bullhead City.jpeg")
        let f4 = city(fn: "Laughlin", fd: "Laughlin is an unincorporated resort town and census-designated place in Clark County, Nevada, United States", fin: "Laughlin.jpeg")
        let f5 = city(fn: "Las Vegas", fd: "Las Vegas, often known simply as Vegas, is the 26th-most populous city in the United States", fin: "Las Vegas.jpeg")
        
        cities.append(f1)
        cities.append(f2)
        cities.append(f3)
        cities.append(f4)
        cities.append(f5)
        
    }
    
    func getCount() -> Int
    {
        return cities.count
    }
    
    func getFruitObject(item:Int) -> city{
        
        return cities[item]
    }
    
    func removeFruitObject(item:Int) {
        
         cities.remove(at: item)
    }
    
    func addFruitObject(name:String, desc: String, image: String) -> city{
        let f = city(fn: name, fd: "filler", fin: "tempe.jpeg")
        cities.append(f)
        return f
    }
    
}
class city
{
    var cityName:String?
    var cityDescription:String?
    var cityImageName:String?
    
    init(fn:String, fd:String, fin:String)
    {
        cityName = fn
        cityDescription = fd
        cityImageName = fin
        
    }
    
    
}
