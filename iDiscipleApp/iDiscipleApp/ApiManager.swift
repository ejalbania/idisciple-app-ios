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
    
    let loadData = "content/all"
    
    let speakersJson = "https://idisciple.ph/2019/apbycon/assets/speakers.json"
    let workshopsJson = "https://idisciple.ph/2019/apbycon/assets/workshops.json"
    
    let responseSuccess = "Success"
    let responseError = "ERR"
    
//    func getDataFromFile(filename: String, dataString: String, onSuccess: @escaping(String) -> Void, onFailure:@escaping(String -> Void)){
//
//        let file = filename //this is the file. we will write to and read from it
//
//        let text = "some text" //just a text
//
//        if let dir = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first {
//
//            let fileURL = dir.appendingPathComponent(file)
//
//            //writing
//            do {
//                try text.write(to: fileURL, atomically: false, encoding: .utf8)
//            }
//            catch {/* error handling here */}
//
//            //reading
//            do {
//                _ = try String(contentsOf: fileURL, encoding: .utf8)
//            }
//            catch {/* error handling here */}
//        }
//    }

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
                    
                    if checkData[0]["name"].stringValue != "" {
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
