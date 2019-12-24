//
//  Profile.swift
//  iDiscipleApp
//
//  Created by Rick Roman on 04/05/2019.
//

import UIKit

class Profile: NSObject {
    
    private(set) var profileID : Int
    private(set) var profileName : String
    
    private(set) var firstName : String
    private(set) var middleName : String
    private(set) var lastName : String
    private(set) var nickName : String
    private(set) var gender : String
    private(set) var country : String
    private(set) var familyGroupID : Int
    private(set) var firstWorkshop : Int
    private(set) var secondWorkshop : Int
    private(set) var imagePath : String
    private(set) var imageName : String
    
    public init(profileID : Int,
                profileName : String,
                firstName : String,
                middleName : String,
                lastName : String,
                nickName : String,
                gender : String,
                country : String,
                familyGroupID : Int,
                firstWorkshop : Int,
                secondWorkshop : Int,
                imagePath : String,
                imageName : String){
        
        self.profileID = profileID
        self.profileName = profileName
        self.firstName = firstName
        self.middleName = middleName
        self.lastName = lastName
        self.nickName = nickName
        self.gender = gender
        self.country = country
        self.familyGroupID = familyGroupID
        self.firstWorkshop = firstWorkshop
        self.secondWorkshop = secondWorkshop
        self.imagePath = imagePath
        self.imageName = imageName
        
    }

}
