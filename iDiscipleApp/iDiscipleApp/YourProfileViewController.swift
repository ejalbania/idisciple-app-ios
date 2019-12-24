//
//  YourProfileViewController.swift
//  iDiscipleApp
//
//  Created by Rick Roman on 29/04/2019.
//

import UIKit
import SwiftyJSON
import Kingfisher
import Alamofire


class YourProfileViewController: DownloaderViewController, UINavigationControllerDelegate, UIImagePickerControllerDelegate {

    var yourProfileView: YourProfileView!
    
    var countryArray : [Country] = []
    var workshopArray : [Workshop] = []
    var familyGroupArray : [FamilyGroup] = []
    var profileArray : [Profile] = []
    
    var userProfile : Profile? = nil
    
    var loadedUser : User? = nil
    
    var callbackClosure: (() -> (Void))?
    var callbackLogout: (() -> (Void))?
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        //self.navigationController?.isNavigationBarHidden = true
        
        yourProfileView = YourProfileView(frame: CGRect.zero)
        self.view.addSubview(yourProfileView)
        
        yourProfileView.autoPinEdgesToSuperviewEdges(with: UIEdgeInsets.zero)
        
        //debugPrint(speakersBioView.speakersBioLabel.frame.origin.y)
        //headerLine
        let headerLine = UIBezierPath(rect: CGRect(x: 0, y: 40, width: yourProfileView.screenSize.width, height: 0.1))
        let headerLayer = CAShapeLayer()
        headerLayer.path = headerLine.cgPath
        headerLayer.strokeColor =  UIColor.withAlphaComponent(.gray)(0.3).cgColor
        yourProfileView.mainView.layer.addSublayer(headerLayer)
        
        //footerLine
        let footerLine = UIBezierPath(rect: CGRect(x: 0, y: 475 - 60, width: yourProfileView.screenSize.width, height: 0.1))
        let footerLayer = CAShapeLayer()
        footerLayer.path = footerLine.cgPath
        footerLayer.strokeColor =  UIColor.withAlphaComponent(.gray)(0.3).cgColor
        yourProfileView.mainView.layer.addSublayer(footerLayer)
        
        //footerDividerLine
        let dividerLine = UIBezierPath(rect: CGRect(x: (yourProfileView.screenSize.width/2) - 35, y: 475-60, width: 0.1, height: 60))
        let dividerLayer = CAShapeLayer()
        dividerLayer.path = dividerLine.cgPath
        dividerLayer.strokeColor =  UIColor.withAlphaComponent(.gray)(0.3).cgColor
        yourProfileView.mainView.layer.addSublayer(dividerLayer)
        
        yourProfileView.dismissButton.addTarget(self, action: #selector(dismissYourProfileView), for: .touchUpInside)
        yourProfileView.changeAvatarButton.addTarget(self, action: #selector(changeAvatarPressed), for: .touchUpInside)
        yourProfileView.logoutButton.addTarget(self, action: #selector(logoutDidPressed), for: .touchUpInside)
        
        DispatchQueue.main.async {
            self.loadCountry()
        }
        
    }
    
    @IBAction func logoutDidPressed(sender: UIButton!){
        
        let logoutAlert = UIAlertController(title: "Log-out", message: "Are you sure you want to log-out?.", preferredStyle: UIAlertController.Style.alert)
        
        logoutAlert.addAction(UIAlertAction(title: "Yes", style: .default, handler: { (action: UIAlertAction!) in
            //Logout
            UserDefaults.standard.set(false, forKey: GlobalConstant.checkLoginState)
            self.moveToLogout()
        }))
        
        logoutAlert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: { (action: UIAlertAction!) in
            debugPrint("Handle Cancel Logic here")
        }))
        
        present(logoutAlert, animated: true, completion: nil)
    }
    
    @IBAction func dismissYourProfileView(sender: UIButton!){
        callbackClosure?()
        dismiss(animated: false, completion: nil)
    }
    
    @IBAction func changeAvatarPressed(sender: UIButton!){
        //dismiss(animated: false, completion: nil)
        debugPrint("Change Avatar")
        openImagePickerOption()
    }
    
    func moveToLogout(){
        callbackLogout?()
        self.dismiss(animated: false, completion: nil)
    }
    
    func openImagePickerOption(){
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.allowsEditing = false

        imagePicker.sourceType = .photoLibrary
        
        self.present(imagePicker, animated: true) {
            debugPrint("Image Picker Showing")
        }
    }
    
    @objc func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage{
            
            uploadImage(image: image)
            //yourProfileView.profileImageView.image = image
        }
        else{
            //error
            debugPrint("Error Image")
        }
        
        self.dismiss(animated: false, completion: nil)
    }
    
    func uploadImage(image: UIImage){
        
        guard let imageData = image.jpegData(compressionQuality: 0.2) else {
            print("Could not get JPEG representation of UIImage")
            return
        }
        
        let urlString = ApiManager.sharedInstance.baseURL + ApiManager.sharedInstance.upload
        
        //Upload
        Alamofire.upload(multipartFormData: { multipartFormData in
            multipartFormData.append(imageData, withName:"file", fileName:"file.jpg", mimeType: "image/jpg")
            multipartFormData.append("\(self.loadedUser?.userID ?? 0)".data(using: String.Encoding.utf8)!, withName: "user_id")
        }, to:urlString)
        { (result) in
            switch result {
            case .success(let upload, _, _):
                
                self.appHelper.alert(message: "Uploading..")
                
                upload.uploadProgress(closure: { (progress) in
                    print("Upload Progress: \(progress.fractionCompleted)")
                })
                
                upload.responseJSON { response in
                    print(response.result.value!)
                    
                    self.reloadJsonData(onSuccess: { string in
                        debugPrint(string)
                        if(string == "profile"){
                            self.appHelper.dismissAlert()
                            self.loadProfiles()
                        }
                        
                    }, onFailure: { error in
                        debugPrint(error)
                        self.appHelper.dismissAlert()
                    })
                }
                
            case .failure(let encodingError):
                print(encodingError)
                self.appHelper.dismissAlert()
            }
        }
    }
    
    func loadCountry(){
        
        countryArray.removeAll()
        
        let filename = "countries"
        
        //Check if country.json exists
        let testRetrieve = JSONCache.getOptional(filename, as: JSON.self)
        if((testRetrieve) != nil){
            //load
            let jsonValue = JSON(testRetrieve!)
            //debugPrint("\(jsonValue)")
            for (_, subJson) in jsonValue[0]["data"]{
                
                self.countryArray.append(Country(countryID: subJson["id"].intValue,
                                                 countryName: subJson["name"].stringValue,
                                                 countryCode: subJson["code"].stringValue))
            }
            
        }else{
            debugPrint("\(filename) not found!")
        }
        
        loadWorkshop()
    }
    
    func loadWorkshop(){
        
        workshopArray.removeAll()
        
        let filename = "workshops"
        
        //Check if schedule.json exists
        let testRetrieve = JSONCache.getOptional(filename, as: JSON.self)
        if((testRetrieve) != nil){
            //load
            let jsonValue = JSON(testRetrieve!)
            //debugPrint("\(jsonValue)")
            for (_, subJson) in jsonValue[0]["data"]{
                
                self.workshopArray.append(Workshop(workshopID: subJson["workshop_id"].intValue,
                                                   workshopName: subJson["workshop_name"].stringValue,
                                                   workshopDescription: subJson["description"].stringValue,
                                                   workshopOutline: subJson["outline"].stringValue,
                                                   workshopSpeakerID: subJson["speaker_id"].intValue,
                                                   workshopDate: subJson["workshop_schedule_date"].stringValue,
                                                   workshopTime: subJson["workshop_schedule_time"].stringValue,
                                                   workshopLocation: subJson["location"].stringValue))
            }
            
        }else{
            debugPrint("\(filename) not found!")
        }
        
        loadFamilyGroup()
        
    }
    
    func loadFamilyGroup(){
        
        familyGroupArray.removeAll()
        
        let filename = "family_groups"
        
        //Check if family_groups.json exists
        let testRetrieve = JSONCache.getOptional(filename, as: JSON.self)
        if((testRetrieve) != nil){
            //load
            let jsonValue = JSON(testRetrieve!)
            //debugPrint("\(jsonValue)")
            for (_, subJson) in jsonValue[0]["data"]{
                
                self.familyGroupArray.append(FamilyGroup(familyGroupID: subJson["fg_id"].intValue,
                                                         familyGroupName: subJson["fg_name"].stringValue,
                                                         familyGroupLeadID: subJson["fg_lead_id"].intValue))
            }
            
        }else{
            debugPrint("\(filename) not found!")
        }
        
        loadProfiles()
    }
    
    func loadProfiles(){
        
        profileArray.removeAll()
        
        let filename = "profile"
        
        //Check if schedule.json exists
        let testRetrieve = JSONCache.getOptional(filename, as: JSON.self)
        if((testRetrieve) != nil){
            //load
            let jsonValue = JSON(testRetrieve!)
            //debugPrint("\(jsonValue)")
            for (_, subJson) in jsonValue[0]["data"]{
                
                self.profileArray.append(Profile(profileID: subJson["id"].intValue,
                                                 profileName: subJson["name"].stringValue,
                                                 firstName: subJson["firstname"].stringValue,
                                                 middleName: subJson["middlename"].stringValue,
                                                 lastName: subJson["lastname"].stringValue,
                                                 nickName: subJson["nickname"].stringValue,
                                                 gender: subJson["gender"].stringValue,
                                                 country: subJson["country"].stringValue,
                                                 familyGroupID: subJson["fg_id"].intValue,
                                                 firstWorkshop: subJson["workshop_number_1"].intValue,
                                                 secondWorkshop: subJson["workshop_number_2"].intValue,
                                                 imagePath: subJson["img_path"].stringValue,
                                                 imageName: subJson["img_name"].stringValue))
            }
            
        }else{
            debugPrint("\(filename) not found!")
        }
        
        loadYourProfileView()
    }
    
    func loadYourProfileView(){
        
        let data  = UserDefaults.standard.object(forKey: "userProfile") as! Data
        loadedUser = NSKeyedUnarchiver.unarchiveObject(with: data) as? User
        
        userProfile = profileArray.first(where: ({ (profileSearch: Profile) -> Bool in
            return profileSearch.profileID == loadedUser!.userID
        }))
        
        if(userProfile != nil){
            //setup image here
            if((userProfile?.imagePath.isEmpty)! && (userProfile?.imageName.isEmpty)!){
                yourProfileView.profileImageView.image = UIImage(named: "country_" + userProfile!.country)
            }else{
                debugPrint(userProfile!.imagePath)
                let imageUrl = userProfile!.imagePath //+ userProfile!.imageName
                yourProfileView.profileImageView.kf.indicatorType = .activity
                yourProfileView.profileImageView.kf.setImage(with: ImageResource(downloadURL:URL(string: imageUrl)!, cacheKey: imageUrl), placeholder: UIImage(named: "country_\(userProfile!.country)"))
            }
            
            yourProfileView.nicknameLabel.text = userProfile?.nickName
            yourProfileView.fullNameLabel.text = userProfile?.profileName
            
            let country = countryArray.first(where: ({ (countrySearch : Country) -> Bool in
                return countrySearch.countryID == Int(userProfile!.country)
            }))
            
            yourProfileView.genderCountryLabel.text = "\((userProfile?.gender) ?? ""), \((country?.countryName) ?? "Philippines")"
            
            //update workshops here
            let workshop1 = workshopArray.first(where: ({ (workshopSearch: Workshop) -> Bool in
                return workshopSearch.workshopID == userProfile?.firstWorkshop
            }))
            
            let workshop2 = workshopArray.first(where: ({ (workshopSearch: Workshop) -> Bool in
                return workshopSearch.workshopID == userProfile?.secondWorkshop
            }))
            
            var workshopText = ""
            if(workshop1?.workshopName != nil){
                workshopText = workshop1!.workshopName
            }
            if(workshop2?.workshopName != nil){
                if(workshop1?.workshopName != nil){
                    workshopText.append(" & \(workshop2?.workshopName ?? "")")
                }else{
                    workshopText = workshop2?.workshopName ?? ""
                }
            }
            
            var workshopString = ""
            if(workshopText == ""){
                workshopString = ""
            }else{
                workshopString = "Attending " + workshopText
            }
            yourProfileView.workshopsLabel.appHelper.halfTextColorChange(fullText: workshopString, changeText: workshopText)
            //yourProfileView.workshopsLabel.text = "Attending " + workshopText
            
            let familyGroup = familyGroupArray.first(where: ({ (familyGroupSearch: FamilyGroup) -> Bool in
                return familyGroupSearch.familyGroupID == userProfile?.familyGroupID
            }))
            
            //            let fgID = familyGroup?.familyGroupID ?? 0
            //            var familyGroupNumberText = "00"
            //            if(fgID < 10){
            //                familyGroupNumberText = "0" + "\((fgID))"
            //            }else{
            //                familyGroupNumberText = "\((fgID))"
            //            }
            
            let familyName = familyGroup?.familyGroupName ?? "None"
            yourProfileView.familyGroupLabel.text = familyName
        }
        
    }

}
