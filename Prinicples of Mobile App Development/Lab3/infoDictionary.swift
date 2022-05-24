//
//  infoDictionary.swift
//  Lab3
//
//  Created by Eduardo Teodosio on 2/14/22.
//

import Foundation
class infoDictionary
{
    // dictionary that stores person records
    var infoRepository : [String:movieRecord] = [String:movieRecord] ()
    var num = 0
    init() { }
  
    func add(_ title:String, _ genre:String, _ ticketSale:Double)
    {
        let pRecord =  movieRecord(n:title, s:genre, a:ticketSale)
        infoRepository[pRecord.title!] = pRecord
        
    }
    
    func add(p:movieRecord)
    {
        print("adding" + p.title!)
        infoRepository[p.title!] = p
        
    }
    
    func search(s:String) -> movieRecord?
    {
        num = 0
        var found = false
        
        for (ssn, _) in infoRepository
        {
            num += 1
            if ssn == s {
            found = true
                break
            }
        }
        if found
        {
           return infoRepository[s]
        }else  {
            num = 0
            return nil
            }
    }
    
    func deleteRec(s:String)
    {
        infoRepository[s] = nil
        
    }
}
