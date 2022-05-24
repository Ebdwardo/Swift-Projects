//
//  PersonalRecords.swift
//  Homework1
//
//  Created by Eduardo Teodosio on 4/5/22.
//

import Foundation

class PersonalRecords
{
    var record:[String:DayInfo] = [:]

    init()
    {
    }

    func getCount() -> Int
    {
        return record.count
    }

    func getDayInfo(item:String) -> DayInfo{
        if (record.keys.contains(item)){
            return record[item]!
        }
        else{
            return DayInfo(fn: 0,d: 0,fd: 0,fin: 0,f: "0")
        }
    }
    func getRecord()->[String:DayInfo]{
        return record
    }

//    func removeInfo(item:Int) {
//
//         record.remove(at: <#T##Dictionary<String, DayInfo>.Index#>)
//    }

    func addInfo(key: String, s:Float32, d: Float32, w: Float, m: Float32, symp: String) -> DayInfo{
        let r = DayInfo(fn:s, d:d, fd:w, fin:m, f:symp)
        record[key] = r
        return r
    }

}

class DayInfo
{
    var SystolicPressure:Float32?
    var DiastolicPressure: Float32?
    var WeightInPounds:Float?
    var MorningSugarLevel:Float32?
    var Symptoms:String?
    
    init(fn:Float32, d:Float32, fd:Float, fin:Float32, f:String)
    {
        SystolicPressure = fn
        DiastolicPressure = d
        WeightInPounds = fd
        MorningSugarLevel = fin
        Symptoms = f
    }
    
    func getSys() -> String{
        return String(SystolicPressure!)
    }
    
    func getDia() -> String{
        return String(DiastolicPressure!)
    }
    
    func getWeight() -> String{
        return String(WeightInPounds!)
    }
    
    func getSug() -> String{
        return String(MorningSugarLevel!)
    }
    
    func getSymp() -> String{
        return Symptoms!
    }
    
}
