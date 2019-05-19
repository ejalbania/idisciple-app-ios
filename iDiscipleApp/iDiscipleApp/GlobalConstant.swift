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
        //formatter.timeZone = TimeZone(abbreviation: "PHT")!
        //formatter.dateFormat = "EEEE, MMM d, yyyy HH:mm"
        formatter.dateFormat = "yyyy-MM-dd"
        return formatter
    }()
    
    static let kTimeSource_formatter: DateFormatter = {
        let formatter = DateFormatter()
        //formatter.timeZone = TimeZone(abbreviation: "PHT")
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
    
    
    static var checkLoginState : String = "isLoggedIn"
    //static var newAvatarUploaded = false
    static var alertShown: Bool = false
    
    static let mapDataArray : [MapArea] =
        [MapArea(areaID: 1, areaCode: "A", areaName: "Grover Tyner", areaDescription: "Administration Building"),
         MapArea(areaID: 2, areaCode: "B", areaName: "Oliver Yost", areaDescription: "Music Building"),
         MapArea(areaID: 3, areaCode: "C", areaName: "Covered Gym", areaDescription: ""),
         MapArea(areaID: 4, areaCode: "D", areaName: "(D1) Libby A. Tyner", areaDescription: "Ladies Dorm"),
         MapArea(areaID: 5, areaCode: "D", areaName: "(D2) Zacharias Dayot Hall", areaDescription: "Men's Dorm"),
         MapArea(areaID: 6, areaCode: "D", areaName: "(D3) International Dorm", areaDescription: ""),
         MapArea(areaID: 7, areaCode: "E", areaName: "Vacation Cottage", areaDescription: ""),
         MapArea(areaID: 8, areaCode: "F", areaName: "Faculty Houses", areaDescription: "1 to 17"),
         MapArea(areaID: 9, areaCode: "G", areaName: "Grawley Bethesda Mission Center", areaDescription: ""),
         MapArea(areaID: 10, areaCode: "H", areaName: "Married Apartments", areaDescription: ""),
         MapArea(areaID: 11, areaCode: "I", areaName: "Guest Units", areaDescription: ""),
         MapArea(areaID: 12, areaCode: "J", areaName: "Chapel B", areaDescription: ""),
         MapArea(areaID: 13, areaCode: "K", areaName: "Tennis Court", areaDescription: ""),
         MapArea(areaID: 14, areaCode: "L", areaName: "Carpentry Shop", areaDescription: ""),
         MapArea(areaID: 15, areaCode: "M", areaName: "Aphi/Prayer Room", areaDescription: ""),
         MapArea(areaID: 16, areaCode: "N", areaName: "Canteen", areaDescription: ""),
         MapArea(areaID: 17, areaCode: "P", areaName: "Patio Refreshment", areaDescription: ""),
         MapArea(areaID: 18, areaCode: "Q", areaName: "Parking Area", areaDescription: ""),
         MapArea(areaID: 19, areaCode: "R", areaName: "Guard House", areaDescription: "1 & 2"),
         MapArea(areaID: 20, areaCode: "S", areaName: "Gate", areaDescription: "1 & 2")]
    
}

