//
//  Loc.swift
//  ClassProject
//
//  Created by Eduardo Teodosio on 3/20/22.
//

import Foundation
import CoreData
import UIKit

class Loc{
    let managedObjectContext:NSManagedObjectContext?
    
    var fetchedResults = [Location]()
    
    init(context: NSManagedObjectContext)
    {
        managedObjectContext = context
    }
    
    func fetchRecord() -> Int {
        // Create a new fetch request using the FruitEntity
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Location")
        //let sort = NSSortDescriptor(key: "name", ascending: true)
        //fetchRequest.sortDescriptors = [sort]
        var x   = 0
        // Execute the fetch request, and cast the results to an array of FruitEnity objects
        fetchedResults = ((try? managedObjectContext!.fetch(fetchRequest)) as? [Location])!
        
        
        x = fetchedResults.count
        
        print(x)
        
        // return howmany entities in the coreData
        return x

    }
    
    func getCity(item:Int) -> Location{
        return fetchedResults[item]
    }
    
    func deleteAll(view: UITableView){
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Location")
        
        // whole fetchRequest object is removed from the managed object context
        let deleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)
        do {
            try self.managedObjectContext!.execute(deleteRequest)
            try self.managedObjectContext!.save()
            
            
        }
        catch _ as NSError {
            // Handle error
        }
        
        view.reloadData()
    }
    
    
}
