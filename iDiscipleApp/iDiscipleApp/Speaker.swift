//
//  Speaker.swift
//  iDiscipleApp
//
//  Created by Rick Roman on 29/04/2019.
//

import UIKit

class Speaker: NSObject {
    
    private(set) var speakerID : Int
    private(set) var name : String
    
    private(set) var bio : String
    private(set) var nationality : Int
    private(set) var facebook : String
    private(set) var twitter : String
    private(set) var website : String
    private(set) var imagePath : String
    private(set) var imageName : String
    private(set) var plenaryTitle : String
    private(set) var plenaryDate : String
    private(set) var plenaryTime : String
    private(set) var workshopID : Int
    private(set) var workshopTitle : String
    private(set) var workshopDate : String
    private(set) var workshopTime : String
    
    //var token: String
    
    public init(speakerID : Int,
                name : String,
                bio : String,
                nationality : Int,
                facebook : String,
                twitter : String,
                website : String,
                imagePath : String,
                imageName : String,
                plenaryTitle : String,
                plenaryDate : String,
                plenaryTime : String,
                workshopID : Int,
                workshopTitle : String,
                workshopDate : String,
                workshopTime : String){
        
        self.speakerID = speakerID
        self.name = name
        self.bio = bio
        self.nationality = nationality
        self.facebook = facebook
        self.twitter = twitter
        self.website = website
        self.imagePath = imagePath
        self.imageName = imageName
        self.plenaryTitle = plenaryTitle
        self.plenaryDate = plenaryDate
        self.plenaryTime = plenaryTime
        self.workshopID = workshopID
        self.workshopTitle = workshopTitle
        self.workshopDate = workshopDate
        self.workshopTime = workshopTime

    }

}
