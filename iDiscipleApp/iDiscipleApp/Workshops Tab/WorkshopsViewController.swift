//
//  WorkshopsViewController.swift
//  iDiscipleApp
//
//  Created by Rick Roman on 28/01/2019.
//

import UIKit
import Popover
import SwiftyJSON

class WorkshopsViewController: UIViewController, WorkshopsTableViewDelegate, WorkshopPopOverViewDelegate {

    var workshopView: WorkshopsView!
    
    let screenSize = UIScreen.main.bounds
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        //Set
        workshopView = WorkshopsView(frame: CGRect.zero)
        self.view.addSubview(workshopView)
        
        // AutoLayout
        workshopView.autoPinEdgesToSuperviewEdges(with: UIEdgeInsets.zero)
        
        workshopView.delegate = self
        workshopView.workshopPopOverView.delegate = self

        //workshopView.workshopTableView.reloadData()
        checkSpeakers()
        
    }
    
    func showPopOverMenu(fromView: UIView, indexPath: Int){
        
        workshopView.selectedIndexPath = indexPath
        workshopView.popOver.show(workshopView.workshopPopOverView, fromView: fromView)
        
    }
    
    //WorkshopView delegate
    func workshopMoreOptionDidPressed(_ workshopsTableView: UITableView, selectedButton: UIButton) {
        //debugPrint(selectedButton.tag)
        //showPopOverMenu(fromView: selectedButton)
    }
    
    func workshopMoreOptionDidPressedWithIndexPath(_ indexPath: Int, selectedButton: UIButton) {
        showPopOverMenu(fromView: selectedButton, indexPath: indexPath)
    }
    
    //Workshop pop over delegate
    func workshopPopOverViewDescriptionPressed() {
        debugPrint("view description")
        workshopView.popOver.dismiss()
        openWorkshopInfoView(indexPath: workshopView.selectedIndexPath!, isOutline: false);
        
    }
    
    func workshopPopOverViewOutlinePressed() {
        debugPrint("view outline")
        workshopView.popOver.dismiss()
        openWorkshopInfoView(indexPath: workshopView.selectedIndexPath!, isOutline: true);
    }
    
    //open workshop detail pop up
    func openWorkshopInfoView(indexPath: Int, isOutline: Bool){
        let newViewController = WorkshopsInfoViewController()
        
        newViewController.isOutline = isOutline
        newViewController.workShopInfo = workshopView.workshopsArray[indexPath]
        
        newViewController.modalPresentationStyle = .overFullScreen
        present(newViewController, animated: false, completion: nil)
    }
    
    func loadWorkshops(){
        
        let urlString = ApiManager.sharedInstance.workshopsJson
        
        ApiManager.sharedInstance.getDataFromJson(url: urlString, onSuccess: { json in
            DispatchQueue.main.async {
                
                let jsonValue = JSON(json)
                //debugPrint("\(jsonValue[0]["data"])")
                
                for (_, subJson) in jsonValue[0]["data"] {
                    //debugPrint("\(subJson["profile"])")
                    //debugPrint("\(subJson["name"])")
                    
                    self.workshopView.workshopsArray.append(Workshop(workshopID: subJson["workshop_id"].intValue,
                                                                     workshopName: subJson["workshop_name"].stringValue,
                                                                     workshopDescription: subJson["description"].stringValue,
                                                                     workshopOutline: subJson["outline"].stringValue,
                                                                     workshopSpeakerID: subJson["speaker_id"].intValue,
                                                                     workshopDate: subJson["workshop_schedule_date"].stringValue,
                                                                     workshopTime: subJson["workshop_schedule_time"].stringValue,
                                                                     workshopLocation: subJson["location"].stringValue))
                    
                }
                
                self.workshopView.workshopTableView.reloadData()
                
            }
        }, onFailure: { error in
            debugPrint("\(error)")
            self.appHelper.dismissAlert()
        })
    }
    
    func checkSpeakers(){
        
         let filename = "speakers"
        
        //Check if speaker.json exists
        let testRetrieve = JSONCache.getOptional(filename, as: JSON.self)
        if((testRetrieve) != nil){
            //load
            let jsonValue = JSON(testRetrieve!)
            //debugPrint("\(jsonValue)")
            for (_, subJson) in jsonValue[0]["data"]{
                self.workshopView.speakersArray.append((Speaker(speakerID: subJson["id"].intValue,
                                                               name: subJson["name"].stringValue,
                                                               bio: subJson["bia"].stringValue,
                                                               nationality: subJson["nationality"].intValue,
                                                               facebook: subJson["facebook"].stringValue,
                                                               twitter: subJson["twitter"].stringValue,
                                                               website: subJson["website"].stringValue,
                                                               imagePath: subJson["img_path"].stringValue,
                                                               imageName: subJson["img_name"].stringValue,
                                                               plenaryTitle: subJson["plenary_title"].stringValue,
                                                               plenaryDate: subJson["plenary_schedule_date"].stringValue,
                                                               plenaryTime: subJson["plenary_schedule_time"].stringValue,
                                                               workshopID: subJson["workshop_id"].intValue,
                                                               workshopTitle: subJson["workshop_title"].stringValue,
                                                               workshopDate: subJson["workshop_schedule_date"].stringValue,
                                                               workshopTime: subJson["workshop_schedule_time"].stringValue)))
            }
        }else{
            debugPrint("\(filename) not found!")
        }
        
        loadWorkshops()
        
    }
    
}
