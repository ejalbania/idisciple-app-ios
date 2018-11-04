//
//  User.swift
//  iDiscipleApp
//
//  Created by Rick Roman on 29/10/2018.
//

import UIKit

class User: NSObject, NSCoding{
    
    private(set) var userID : Int
    private(set) var userName : String
    
    private(set) var firstName : String
    private(set) var middleName : String
    private(set) var lastName : String
    private(set) var nickName : String
    private(set) var mobileNo : String
    private(set) var birthDate : Date
    private(set) var gender : String
    private(set) var country : String
    
    private(set) var token: String
    
    public init(userID: Int,
                userName: String,
                firstName: String,
                middleName: String,
                lastName: String,
                nickName : String,
                mobileNo : String,
                birthDate : Date,
                gender : String,
                country : String,
                token: String){
        
        self.userID = userID
        self.userName = userName
        self.firstName = firstName
        self.middleName = middleName
        self.lastName = lastName
        self.nickName = nickName
        self.mobileNo = mobileNo
        self.birthDate = birthDate
        self.gender = gender
        self.country = country
        
        self.token = token
    }
    
    required convenience init(coder aDecoder: NSCoder) {
        
        let userID = aDecoder.decodeInteger(forKey: "userID") 
        let userName = aDecoder.decodeObject(forKey: "userName") as! String
        
        let firstName = aDecoder.decodeObject(forKey: "firstName") as! String
        let middleName = aDecoder.decodeObject(forKey: "middleName") as! String
        let lastName = aDecoder.decodeObject(forKey: "lastName") as! String
        
        let nickName = aDecoder.decodeObject(forKey: "nickName") as! String
        let mobileNo = aDecoder.decodeObject(forKey: "mobileNo") as! String
        let birthDate = aDecoder.decodeObject(forKey: "birthDate") as! Date
        let gender = aDecoder.decodeObject(forKey: "gender") as! String
        let country = aDecoder.decodeObject(forKey: "country") as! String
        
        let token = aDecoder.decodeObject(forKey: "token") as! String
        
        
        //self.init(firstName: firstName, middleInitial: middleInitial, lastName: lastName, token: token)
        
        self.init(userID: userID, userName: userName, firstName: firstName, middleName: middleName, lastName: lastName, nickName: nickName, mobileNo: mobileNo, birthDate: birthDate, gender: gender, country: country, token: token)
    }
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(userID, forKey: "userID")
        aCoder.encode(userName, forKey: "userName")
        
        aCoder.encode(firstName, forKey: "firstName")
        aCoder.encode(middleName, forKey: "middleName")
        aCoder.encode(lastName, forKey: "lastName")
        
        aCoder.encode(nickName, forKey: "nickName")
        aCoder.encode(mobileNo, forKey: "mobileNo")
        aCoder.encode(birthDate, forKey: "birthDate")
        aCoder.encode(gender, forKey: "gender")
        aCoder.encode(country, forKey: "country")
        
        aCoder.encode(token, forKey: "token")
    }
}
