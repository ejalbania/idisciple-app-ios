//
//  Workshop.swift
//  iDiscipleApp
//
//  Created by Rick Roman on 02/05/2019.
//

import UIKit

class Workshop: NSObject {
    
    private(set) var workshopID : Int
    private(set) var workshopName : String
    
    private(set) var workshopDescription : String
    private(set) var workshopOutline : String
    private(set) var workshopSpeakerID : Int
    private(set) var workshopDate : String
    private(set) var workshopTime : String
    private(set) var workshopLocation : String
    
    //var token: String
    
    public init(workshopID : Int,
                workshopName : String,
                workshopDescription : String,
                workshopOutline : String,
                workshopSpeakerID : Int,
                workshopDate : String,
                workshopTime : String,
                workshopLocation: String){
        
        self.workshopID = workshopID
        self.workshopName = workshopName
        self.workshopDescription = workshopDescription
        self.workshopOutline = workshopOutline
        self.workshopSpeakerID = workshopSpeakerID
        self.workshopDate = workshopDate
        self.workshopTime = workshopTime
        self.workshopLocation = workshopLocation
    }

}
