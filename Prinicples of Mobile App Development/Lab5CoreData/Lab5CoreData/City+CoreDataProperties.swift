//
//  City+CoreDataProperties.swift
//  Lab5CoreData
//
//  Created by Eduardo Teodosio on 3/12/22.
//
//

import Foundation
import CoreData


extension City {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<City> {
        return NSFetchRequest<City>(entityName: "City")
    }

    @NSManaged public var name: String?
    @NSManaged public var picture: NSData?
    @NSManaged public var cityDescription: String?

}

extension City : Identifiable {

}
