//
//  MapArea.swift
//  iDiscipleApp
//
//  Created by Rick Roman on 09/05/2019.
//

import UIKit

class MapArea: NSObject {
    private(set) var areaID : Int
    private(set) var areaCode : String
    private(set) var areaName : String
    private(set) var areaDescription : String
    
    public init(areaID : Int,
                areaCode : String,
                areaName : String,
                areaDescription: String){
        
        self.areaID = areaID
        self.areaCode = areaCode
        self.areaName = areaName
        self.areaDescription = areaDescription
        
    }
}
