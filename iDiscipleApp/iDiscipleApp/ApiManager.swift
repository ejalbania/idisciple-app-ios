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
    
    let responseSuccess = "Success"
    let responseError = "ERR"
    
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
