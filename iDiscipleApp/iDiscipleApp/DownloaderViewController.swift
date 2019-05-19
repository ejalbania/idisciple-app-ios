//
//  DownloaderViewController.swift
//  iDiscipleApp
//
//  Created by Rick Roman on 07/05/2019.
//

import UIKit
import SwiftyJSON

class DownloaderViewController: ViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    func reloadJsonData(onSuccess: @escaping(String) -> Void, onFailure: @escaping(String)-> Void){
        
        var urlString = ApiManager.sharedInstance.baseURL + ApiManager.sharedInstance.loadData + "?user_id=" + "\(1)"
        //Test Check for loaded Api_Token
        if let data = UserDefaults.standard.data(forKey: "userProfile"),
            let user = NSKeyedUnarchiver.unarchiveObject(with: data) as? User{
            //debugPrint("Loaded User Token: \(user.token)")
            urlString = ApiManager.sharedInstance.baseURL + ApiManager.sharedInstance.loadData + "?user_id=" + "\(user.userID)"
        } else {
            print("There is an issue")
        }
        
        debugPrint(urlString)
        
        ApiManager.sharedInstance.getDataWithRequest(requestUrl: urlString, onSuccess: { json in
            DispatchQueue.main.async {
                
                let jsonValue = JSON(json)
                
                //debugPrint("\(jsonValue["data"]["assets"]["speakers"]["path_file"])")
                
                let profilePathFile = jsonValue["data"]["assets"]["profile"]["path_file"].stringValue
                self.loadJsonData(urlString: profilePathFile, fileName: "profile", forUpdate: jsonValue["data"]["assets"]["profile"]["update_now"].boolValue, onSuccess: {
                    onSuccess("profile")
                })
                
                let speakerPathFile = jsonValue["data"]["assets"]["speakers"]["path_file"].stringValue
                self.loadJsonData(urlString: speakerPathFile, fileName: "speakers", forUpdate: jsonValue["data"]["assets"]["speakers"]["update_now"].boolValue, onSuccess: {
                    onSuccess("speakers")
                })
                
                let workshopPathFile = jsonValue["data"]["assets"]["workshops"]["path_file"].stringValue
                self.loadJsonData(urlString: workshopPathFile, fileName: "workshops", forUpdate: jsonValue["data"]["assets"]["workshops"]["update_now"].boolValue, onSuccess: {
                    onSuccess("workshops")
                })
                
                let schedulePathFile = jsonValue["data"]["assets"]["schedule"]["path_file"].stringValue
                self.loadJsonData(urlString: schedulePathFile, fileName: "schedule", forUpdate: jsonValue["data"]["assets"]["schedule"]["update_now"].boolValue, onSuccess: {
                    onSuccess("schedule")
                })
                
                let countryPathFile = jsonValue["data"]["assets"]["countries"]["path_file"].stringValue
                self.loadJsonData(urlString: countryPathFile, fileName: "countries", forUpdate: jsonValue["data"]["assets"]["countries"]["update_now"].boolValue, onSuccess: {
                    onSuccess("countries")
                })
                
                let familyGroupPathFile = jsonValue["data"]["assets"]["family_groups"]["path_file"].stringValue
                self.loadJsonData(urlString: familyGroupPathFile, fileName: "family_groups", forUpdate: jsonValue["data"]["assets"]["family_groups"]["update_now"].boolValue, onSuccess: {
                    onSuccess("family_groups")
                })
                
            }
        }, onFailure: { error in
            onFailure(error)
            debugPrint("\(error)")
        })
    }
    
    func loadJsonData(urlString: String, fileName: String, forUpdate: Bool, onSuccess: @escaping() -> Void){
        
        //Check if speaker.json exists
        //let testRetrieve = JSONCache.getOptional(fileName, as: JSON.self)
        //if((testRetrieve) == nil || forUpdate){
            //save
            ApiManager.sharedInstance.getDataFromJson(url: urlString, onSuccess: { json in
                DispatchQueue.main.async {
                    
                    let jsonValue = JSON(json)
                    JSONCache.set(jsonValue, as: fileName)
                    onSuccess()
                    
                }
            }, onFailure: { error in
                debugPrint("\(error)")
            })
        //}
    }
    

}
