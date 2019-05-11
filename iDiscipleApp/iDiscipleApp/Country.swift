//
//  Country.swift
//  iDiscipleApp
//
//  Created by Rick Roman on 06/05/2019.
//

import UIKit

class Country: NSObject {
    
    private(set) var countryID : Int
    private(set) var countryName : String
    private(set) var countryCode : String
    
    public init(countryID : Int,
                countryName : String,
                countryCode : String){
        
        self.countryID = countryID
        self.countryName = countryName
        self.countryCode = countryCode
        
    }

}
