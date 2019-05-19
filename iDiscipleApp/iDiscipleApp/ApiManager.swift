//
//  ApiManager.swift
//  iDiscipleApp
//
//  Created by Rick Roman on 28/10/2018.
//

import SwiftyJSON
import Alamofire
//import AlamofireImage

class ApiManager{
    
    static let sharedInstance = ApiManager();
    
    let baseURL = "https://idisciple.ph/API/public/"
    
    let login = "auth/login"
    let firstLogPasswordUpdate = "user/first-time"
    let forgotPassword = "user/reset-password"
    let upload = "user/photo"
    
    let loadData = "content/all"
    
    let speakersJson = "https://idisciple.ph/2019/apbycon/assets/speakers.json"
    let workshopsJson = "https://idisciple.ph/2019/apbycon/assets/workshops.json"
    let scheduleJson = "https://idisciple.ph/2019/apbycon/assets/schedule.json"
    let profileJson = "https://idisciple.ph/2019/apbycon/assets/profile.json"
    let familyGroupsJson = "https://idisciple.ph/2019/apbycon/assets/family_groups.json"
    let countriesJson = "https://idisciple.ph/2019/apbycon/assets/countries.json"
    let resourcesJson = "https://idisciple.ph/2019/apbycon/assets/resources.json"
    let aboutJson = "https://idisciple.ph/2019/apbycon/assets/about.json"
    
    let responseSuccess = "Success"
    let responseError = "ERR"
    
    func reloadJsonData(urlString: String, fileName: String, onSuccess: @escaping(String) -> Void, onFailure: @escaping(String)-> Void){
        //save
        ApiManager.sharedInstance.getDataFromJson(url: urlString, onSuccess: { json in
            DispatchQueue.main.async {
                
                let jsonValue = JSON(json)
                JSONCache.set(jsonValue, as: fileName)
                onSuccess(fileName)
            }
        }, onFailure: { error in
            debugPrint("\(error)")
            onFailure(error)
        })
    }
    
    
    func getDataFromJson(url: String, onSuccess: @escaping([Dictionary<String, Any>]) -> Void,  onFailure: @escaping(String) -> Void){
        
        Alamofire.request(url)
            .validate()
            .responseJSON { response in
                //debugPrint(response.result)
                switch response.result {
                case .success(let data):
                    let checkData = JSON(data)
//                    debugPrint(checkData[0]["data"])
//                    debugPrint(checkData[0]["name"])
                    
                    if checkData[0]["name"].stringValue != "" || !checkData[0]["data"].arrayValue.isEmpty {
                        onSuccess(data as! Array)
                    }else{
                        debugPrint("ERROR")
                        onFailure(checkData["message"].stringValue)
                    }
                case .failure(let error):
                    //print("Request failed with error: \(error.localizedDescription)")
                    debugPrint("ERROR")
                    onFailure(error.localizedDescription)
                }
        }
    }
    
    
    //GET
    func getDataWithRequest(requestUrl: String, onSuccess: @escaping(Dictionary<String, Any>) -> Void,  onFailure: @escaping(String) -> Void){
        
        Alamofire.request(requestUrl)
            .validate()
            .responseJSON { response in
                //debugPrint(response.result)
                switch response.result {
                case .success(let data):
                    
                    let checkData = JSON(data)
                    if checkData["status"].stringValue == self.responseSuccess{
                        onSuccess(data as! Dictionary)
                    }else{
                        debugPrint("ERROR")
                        onFailure(checkData["message"].stringValue)
                    }
                case .failure(let error):
                    //print("Request failed with error: \(error.localizedDescription)")
                    debugPrint("ERROR")
                    onFailure(error.localizedDescription)
                }
        }
    }
    
    //POST
    func postDataWithRequest(requestUrl: String, params: Dictionary<String, Any>, onSuccess: @escaping(Dictionary<String, Any>) -> Void,  onFailure: @escaping(String) -> Void){
        
        Alamofire.request(requestUrl, method: .post, parameters:params, encoding: URLEncoding.default, headers: nil)
            .validate()
            .responseJSON{ response in
                
                switch response.result {
                case .success(let data):
                    
                    let checkData = JSON(data)
                    if checkData["status"].stringValue == self.responseSuccess{
                        onSuccess(data as! Dictionary)
                    }else{
                        debugPrint("ErrorResponse from WebService")
                        onFailure(checkData["responseMessage"].stringValue)
                    }
                case .failure(let error):
                    debugPrint("Request Error")
                    debugPrint(error)
                    //print("Request failed with error: \(error.localizedDescription)")
                    onFailure(error.localizedDescription)
                }
        }
    }
    
    //PUT
    func putDataWithRequest(requestUrl: String, params: Dictionary<String, Any>, onSuccess: @escaping(Dictionary<String, Any>) -> Void,  onFailure: @escaping(String) -> Void){
        
        Alamofire.request(requestUrl, method: .put, parameters:params, encoding: URLEncoding.default, headers: nil)
            .validate()
            .responseJSON{ response in
                
                switch response.result {
                case .success(let data):
                    
                    let checkData = JSON(data)
                    if checkData["status"].stringValue == self.responseSuccess{
                        onSuccess(data as! Dictionary)
                    }else{
                        debugPrint("ErrorResponse from WebService")
                        onFailure(checkData["responseMessage"].stringValue)
                    }
                case .failure(let error):
                    debugPrint("Request Error")
                    //print("Request failed with error: \(error.localizedDescription)")
                    onFailure(error.localizedDescription)
                }
        }
    }

    
    
}
