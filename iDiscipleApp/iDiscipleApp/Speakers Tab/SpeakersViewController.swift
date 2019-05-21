//
//  SpeakersViewController.swift
//  iDiscipleApp
//
//  Created by Rick Roman on 11/01/2019.
//

import UIKit
import Kingfisher
import SwiftyJSON

let cellReuseIdentifier = "SpeakerCollectionViewCell"

class SpeakersViewController: DownloaderViewController,  UICollectionViewDataSource, UICollectionViewDelegate {
    
    var speakersView: SpeakersView!
    var speakersCollectionView: SpeakersCollectionView!
    
    var speakerArray : [Speaker] = []
    
    let screenSize = UIScreen.main.bounds

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        //Set
        
        speakersView = SpeakersView(frame: CGRect.zero)
        self.view.addSubview(speakersView)
        
        speakersCollectionView = SpeakersCollectionView(frame: CGRect(x: 0.0, y: 0.0, width: screenSize.width, height: screenSize.height))
        speakersView.addSubview(speakersCollectionView)
        
        // AutoLayout
        speakersView.autoPinEdgesToSuperviewEdges(with: UIEdgeInsets.zero)
        
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 20, left: 10, bottom: 20, right: 10)
        layout.itemSize = CGSize(width: (screenSize.width/2 - 15), height: 250)
        
        speakersCollectionView.speakersCV = UICollectionView(frame: speakersCollectionView.frame, collectionViewLayout: layout)
        speakersCollectionView.speakersCV.dataSource = self
        speakersCollectionView.speakersCV.delegate = self
        speakersCollectionView.speakersCV.register(SpeakersCollectionViewCell.self, forCellWithReuseIdentifier: cellReuseIdentifier)
        speakersCollectionView.speakersCV.backgroundColor = .clear
        speakersCollectionView.addSubview(speakersCollectionView.speakersCV)
        
        if #available(iOS 10.0, *) {
            speakersCollectionView.speakersCV.refreshControl = speakersCollectionView.refreshControl
        } else {
            speakersCollectionView.speakersCV.addSubview(speakersCollectionView.refreshControl)
        }
        
         speakersCollectionView.refreshControl.addTarget(self, action: #selector(reloadData(_:)), for: .valueChanged)
        
        //speakersCollectionView.speakerView.isHidden = true;
        DispatchQueue.main.async {
               self.loadSpeakers()
        }
   
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        loadSpeakers()
    }
    
    @objc private func reloadData(_ sender: Any) {
        // Reload data
        debugPrint("call reload here")
        reloadJsonData(onSuccess: { string in
            
            DispatchQueue.main.async {
                self.doneReloading()
            }
            
        }, onFailure: { error in
            debugPrint(error)
            self.doneReloading()
        })
    }
    
    func doneReloading() {
        
        speakersCollectionView.refreshControl.endRefreshing()
        loadSpeakers()
    }
    
    func loadSpeakers(){
        
        speakerArray.removeAll()
        let filename = "speakers"
        
        //Check if schedule.json exists
        let testRetrieve = JSONCache.getOptional(filename, as: JSON.self)
        if((testRetrieve) != nil){
            //load
            let jsonValue = JSON(testRetrieve!)
            //debugPrint("\(jsonValue)")
            for (_, subJson) in jsonValue[0]["data"]{
                self.speakerArray.append(Speaker(speakerID: subJson["id"].intValue,
                                                                        name: subJson["name"].stringValue,
                                                                        bio: subJson["bio"].stringValue,
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
            //self.reloadCollectionView()
            self.speakersCollectionView.updateConstraints()
            
            
        }else{
            debugPrint("\(filename) not found!")
        }
       
    }
    
//    func reloadCollectionView(){
//
//        speakerArray.removeAll()
//        //speakerArray = loadedArray
//        speakersCollectionView.speakersCV.reloadData()
//    }
    
//    // MARK: SpeakersCollectionView Delegate
//    
//    func speakersCollectionDidSelect(_ speakersCollectionView: SpeakersCollectionView, indexPathRow: Int) {
//        debugPrint("Open Pop up: " + "\(indexPathRow)")
//        
//        let newViewController = SpeakersBioViewController()
//        //self.navigationController?.modal(newViewController, animated: false)
//        newViewController.modalPresentationStyle = .overFullScreen
//        newViewController.speakerBio = speakerArray[indexPathRow]
//        present(newViewController, animated: false, completion: nil)
//        
//    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if speakerArray.isEmpty{
            return 0
        }
        else{
            return speakerArray.count
            
        }
        //return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let speakerCell = collectionView.dequeueReusableCell(withReuseIdentifier: cellReuseIdentifier, for: indexPath) as! SpeakersCollectionViewCell
        //speakerCell.backgroundColor = .blue
        if (!speakerArray.isEmpty){
            let cellSpeaker = speakerArray[indexPath.row]
            
            let imageUrl = cellSpeaker.imagePath + cellSpeaker.imageName
            
            speakerCell.speakerImageView.kf.indicatorType = .activity
            //speakerCell.speakerImageView.kf.placeholder?.add(to: UIImageView(image: UIImage(named: "country_\(cellSpeaker.nationality)")))
            speakerCell.speakerImageView.kf.setImage(with: ImageResource(downloadURL:URL(string: imageUrl)!, cacheKey: imageUrl), placeholder: UIImage(named: "country_\(cellSpeaker.nationality)"))
            
            speakerCell.speakerNameLabel.text = cellSpeaker.name
            speakerCell.plenaryTopicLabel.text = cellSpeaker.plenaryTitle
            speakerCell.dateAndTimeLabel.text = cellSpeaker.plenaryDate + " " + cellSpeaker.plenaryTime
        }
        
        return speakerCell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath){
        
        DispatchQueue.main.async {
            let newViewController = SpeakersBioViewController()
            //self.navigationController?.modal(newViewController, animated: false)
            newViewController.modalPresentationStyle = .overFullScreen
            newViewController.speakerBio = self.speakerArray[indexPath.row]
            self.present(newViewController, animated: false, completion: nil)
        }
    }
}
