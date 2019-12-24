//
//  Schedule.swift
//  iDiscipleApp
//
//  Created by Rick Roman on 04/05/2019.
//

import UIKit

class Schedule: NSObject {
    
    private(set) var schedID : Int
    private(set) var schedDate : String
    private(set) var schedStartTime : String
    private(set) var schedEndTime : String
    private(set) var schedName : String
    private(set) var schedVenue : String
    private(set) var schedWorkshopID : Int
    
    public init(schedID : Int,
                schedDate : String,
                schedStartTime : String,
                schedEndTime : String,
                schedName : String,
                schedVenue : String,
                schedWorkshopID : Int){
        
        self.schedID = schedID
        self.schedDate = schedDate
        self.schedStartTime = schedStartTime
        self.schedEndTime = schedEndTime
        self.schedName = schedName
        self.schedVenue = schedVenue
        self.schedWorkshopID = schedWorkshopID
    }

}
