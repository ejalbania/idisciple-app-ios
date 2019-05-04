//
//  GlobalConstant.swift
//  iDiscipleApp
//
//  Created by Rick Roman on 30/04/2019.
//

import UIKit

struct GlobalConstant {
    
    static let kDateSource_formatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.timeZone = TimeZone(abbreviation: "PHT")!
        //formatter.dateFormat = "EEEE, MMM d, yyyy HH:mm"
        formatter.dateFormat = "yyyy-MM-dd"
        return formatter
    }()
    
    static let kTimeSource_formatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.timeZone = TimeZone(abbreviation: "PHT")
        formatter.dateFormat = "h:mm a"
        return formatter
    }()
    
    static var speakerJson : String = "https://idisciple.ph/2019/apbycon/assets/speakers.json"
    static var workshopJson : String = "https://idisciple.ph/2019/apbycon/assets/workshops.json"
    static var scheduleJson : String = "https://idisciple.ph/2019/apbycon/assets/schedule.json"
    static var familyGroupJson : String = "https://idisciple.ph/2019/apbycon/assets/profile.json"
    static var countriesJson : String = "https://idisciple.ph/2019/apbycon/assets/countries.json"
    static var resourceJson : String = "https://idisciple.ph/2019/apbycon/assets/resources.json"
    static var aboutJson : String = "https://idisciple.ph/2019/apbycon/assets/about.json"
    
}

