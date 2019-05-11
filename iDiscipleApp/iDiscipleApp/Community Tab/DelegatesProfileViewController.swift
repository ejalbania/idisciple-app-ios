//
//  DelegatesProfileViewController.swift
//  iDiscipleApp
//
//  Created by Rick Roman on 27/04/2019.
//

import UIKit
import SwiftyJSON
import Kingfisher

class DelegatesProfileViewController: UIViewController {

    var delegatesProfileView: DelegatesProfileView!
    
    
    var countryArray : [Country] = []
    var workshopArray : [Workshop] = []
    var familyGroupArray : [FamilyGroup] = []
    
    var delegateProfile : Profile? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        //self.navigationController?.isNavigationBarHidden = true
        
        delegatesProfileView = DelegatesProfileView(frame: CGRect.zero)
        self.view.addSubview(delegatesProfileView)
        
        delegatesProfileView.autoPinEdgesToSuperviewEdges(with: UIEdgeInsets.zero)
        
        //debugPrint(speakersBioView.speakersBioLabel.frame.origin.y)
        //headerLine
        let headerLine = UIBezierPath(rect: CGRect(x: 0, y: 40, width: delegatesProfileView.screenSize.width, height: 0.1))
        let headerLayer = CAShapeLayer()
        headerLayer.path = headerLine.cgPath
        headerLayer.strokeColor =  UIColor.withAlphaComponent(.gray)(0.3).cgColor
        delegatesProfileView.mainView.layer.addSublayer(headerLayer)
        
        //footerLine
        let footerLine = UIBezierPath(rect: CGRect(x: 0, y: 470 - 60, width: delegatesProfileView.screenSize.width, height: 0.1))
        let footerLayer = CAShapeLayer()
        footerLayer.path = footerLine.cgPath
        footerLayer.strokeColor =  UIColor.withAlphaComponent(.gray)(0.3).cgColor
        delegatesProfileView.mainView.layer.addSublayer(footerLayer)
        
        delegatesProfileView.dismissButton.addTarget(self, action: #selector(dismissDelegatesProfileView), for: .touchUpInside)
        
        loadCountry()
        
    }
    
    @IBAction func dismissDelegatesProfileView(sender: UIButton!){
        dismiss(animated: false, completion: nil)
    }
    
    func loadCountry(){
        
        let filename = "countries"
        
        //Check if schedule.json exists
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
        
        loadDelegateProfileView()
        
    }
    
    func loadDelegateProfileView(){
        
        if(delegateProfile != nil){
            //setup image here
            if((delegateProfile?.imagePath.isEmpty)! && (delegateProfile?.imageName.isEmpty)!){
                delegatesProfileView.profileImageView.image = UIImage(named: "country_" + delegateProfile!.country)
            }else{
                let imageUrl = delegateProfile!.imagePath //+ delegateProfile!.imageName
                delegatesProfileView.profileImageView.kf.indicatorType = .activity
                delegatesProfileView.profileImageView.kf.setImage(with: ImageResource(downloadURL:URL(string: imageUrl)!, cacheKey: imageUrl), placeholder: UIImage(named: "country_\(delegateProfile!.country)"))
            }
            
            delegatesProfileView.nicknameLabel.text = delegateProfile?.nickName
            delegatesProfileView.fullNameLabel.text = delegateProfile?.profileName
            
            let country = countryArray.first(where: ({ (countrySearch : Country) -> Bool in
                return countrySearch.countryID == Int(delegateProfile!.country)
                }))
            
            delegatesProfileView.genderCountryLabel.text = "\((delegateProfile?.gender)!), \((country?.countryName)!)"
            
            //update workshops here
            let workshop1 = workshopArray.first(where: ({ (workshopSearch: Workshop) -> Bool in
                return workshopSearch.workshopID == delegateProfile?.firstWorkshop
            }))
            
            let workshop2 = workshopArray.first(where: ({ (workshopSearch: Workshop) -> Bool in
                return workshopSearch.workshopID == delegateProfile?.secondWorkshop
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
            
            delegatesProfileView.workshopsLabel.text = workshopText
            
            let familyGroup = familyGroupArray.first(where: ({ (familyGroupSearch: FamilyGroup) -> Bool in
                return familyGroupSearch.familyGroupID == delegateProfile?.familyGroupID
                }))
            
//            let fgID = familyGroup?.familyGroupID ?? 0
//            var familyGroupNumberText = "00"
//            if(fgID < 10){
//                familyGroupNumberText = "0" + "\((fgID))"
//            }else{
//                familyGroupNumberText = "\((fgID))"
//            }
            
            let familyName = familyGroup?.familyGroupName ?? "None"
            delegatesProfileView.familyGroupLabel.text = familyName
        }
    }

}
