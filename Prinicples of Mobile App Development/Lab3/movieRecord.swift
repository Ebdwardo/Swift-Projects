//
//  movieRecord.swift
//  Lab3
//
//  Created by Eduardo Teodosio on 2/14/22.
//

import Foundation
class movieRecord
{
    var title:String? = nil
    var genre:String? = nil
    var ticketSale:Double? = nil
    
    init(n:String, s:String, a:Double) {
        self.title = n
        self.genre = s
        self.ticketSale = a
    }
    
    func change_Ticket(newTicket:Double)
    {
        self.ticketSale = newTicket;
    }
    
}
