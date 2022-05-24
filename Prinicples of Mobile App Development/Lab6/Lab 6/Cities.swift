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
        let f = city(fn: name, fd: desc, fin: image)
        cities.append(f)
        return f
    }
    
    func removeAll(){
        cities.removeAll()
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
