//
//  FamilyGroup.swift
//  iDiscipleApp
//
//  Created by Rick Roman on 04/05/2019.
//

import UIKit

class FamilyGroup: NSObject {
    
    private(set) var familyGroupID : Int
    private(set) var familyGroupName : String
    private(set) var familyGroupLeadID : Int
    
    public init(familyGroupID : Int,
                familyGroupName : String,
                familyGroupLeadID : Int){
        
        self.familyGroupID = familyGroupID
        self.familyGroupName = familyGroupName
        self.familyGroupLeadID = familyGroupLeadID
        
    }

}
