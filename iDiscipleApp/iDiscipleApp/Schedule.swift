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
    
    
//    "sched_id": "1",
//    "sched_date": "2019-05-21",
//    "sched_start_time": "9:00 AM",
//    "sched_end_time": "3:00 PM",
//    "sched_name": "Registration",
//    "sched_venue": "PBTS Gym",
//    "workshop_id": 0
    //var token: String
    
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
