//
//  Location+CoreDataProperties.swift
//  ClassProject
//
//  Created by Eduardo Teodosio on 4/22/22.
//
//

import Foundation
import CoreData


extension Location {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Location> {
        return NSFetchRequest<Location>(entityName: "Location")
    }

    @NSManaged public var name: String?
    @NSManaged public var address: String?
    @NSManaged public var picture: NSData?

}

extension Location : Identifiable {

}
