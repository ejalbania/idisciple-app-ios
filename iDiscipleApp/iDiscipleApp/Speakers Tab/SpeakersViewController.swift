//
//  SpeakersViewController.swift
//  iDiscipleApp
//
//  Created by Rick Roman on 11/01/2019.
//

import UIKit
import SwiftyJSON

class SpeakersViewController: UIViewController, SpeakersCollectionViewDelegate {
    
    var speakersView: SpeakersView!
    var speakersCollectionView: SpeakersCollectionView!
    
    
    let screenSize = UIScreen.main.bounds

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        //Set
        
        speakersView = SpeakersView(frame: CGRect.zero)
        self.view.addSubview(speakersView)
        
        speakersCollectionView = SpeakersCollectionView(frame: CGRect(x: 0.0, y: 0.0, width: screenSize.width, height: screenSize.height))
        speakersCollectionView.delegate = self
        speakersView.addSubview(speakersCollectionView)
        
        //speakersCollectionView.speakerView.isHidden = true;
        loadSpeakers()
        
        // AutoLayout
        speakersView.autoPinEdgesToSuperviewEdges(with: UIEdgeInsets.zero)
        
    }
    
    func loadSpeakers(){
        
        let urlString = ApiManager.sharedInstance.speakersJson
        
        ApiManager.sharedInstance.getDataFromJson(url: urlString, onSuccess: { json in
             DispatchQueue.main.async {
                
                let jsonValue = JSON(json)
                //debugPrint("\(jsonValue)")
                
                for (_, subJson) in jsonValue[0]["data"] {
        
                    self.speakersCollectionView.speakerArray.append(Speaker(speakerID: subJson["id"].intValue,
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
                                                 workshopTime: subJson["workshop_schedule_time"].stringValue))
                    
                }
                
                self.speakersCollectionView.speakersCV.reloadData()
                self.speakersCollectionView.updateConstraints()
                
            }
        }, onFailure: { error in
            debugPrint("\(error)")
            //self.appHelper.dismissAlert()
        })
       
    }
    
    // MARK: SpeakersCollectionView Delegate
    func speakersCollectionDidSelect(_ speakersCollectionView: SpeakersCollectionView, indexPathRow: Int) {
        debugPrint("Open Pop up: " + "\(indexPathRow)")
        
        let newViewController = SpeakersBioViewController()
        //self.navigationController?.modal(newViewController, animated: false)
        newViewController.modalPresentationStyle = .overFullScreen
        newViewController.speakerBio = speakersCollectionView.speakerArray[indexPathRow]
        present(newViewController, animated: false, completion: nil)
    }
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
