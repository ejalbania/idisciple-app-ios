//
//  WorkshopsViewController.swift
//  iDiscipleApp
//
//  Created by Rick Roman on 28/01/2019.
//

import UIKit
import Popover
import SwiftyJSON

class WorkshopsViewController: DownloaderViewController, UITableViewDelegate, UITableViewDataSource, WorkshopPopOverViewDelegate {

    var workshopView: WorkshopsView!
    let screenSize = UIScreen.main.bounds
    
    var workshopsArray : [Workshop] = []
    var speakersArray : [Speaker] = []
    var profileArray : [Profile] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        //Set
        workshopView = WorkshopsView(frame: CGRect.zero)
        self.view.addSubview(workshopView)
        
        // AutoLayout
        workshopView.autoPinEdgesToSuperviewEdges(with: UIEdgeInsets.zero)
        
        workshopView.workshopPopOverView.delegate = self
        
        workshopView.workshopTableView.delegate = self
        workshopView.workshopTableView.dataSource = self
        workshopView.workshopTableView.register(WorkshopsTableViewCell.self, forCellReuseIdentifier: "WorkshopsTableViewCell")
        
        workshopView.refreshControl.addTarget(self, action: #selector(reloadData(_:)), for: .valueChanged)

        //workshopView.workshopTableView.reloadData()
        DispatchQueue.main.async {
            self.reloadTab()
        }

        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        //reloadTab()
    }
    
    func reloadTab(){
        
        checkSpeakers()
        loadWorkshops()
        loadProfiles()
        
        self.workshopView.workshopTableView.reloadData()
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
        
        self.workshopView.refreshControl.endRefreshing()
        reloadTab()
    }

    
    func showPopOverMenu(fromView: UIView, indexPath: Int){
        
        workshopView.selectedIndexPath = indexPath
        workshopView.popOver.show(workshopView.workshopPopOverView, fromView: fromView)
        
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
        newViewController.workShopInfo = workshopsArray[indexPath]
        
        newViewController.modalPresentationStyle = .overFullScreen
        present(newViewController, animated: false, completion: nil)
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
            
            //self.workshopView.workshopTableView.reloadData()
            
        }else{
            debugPrint("\(filename) not found!")
        }
        
    }
    
    func loadWorkshops(){
        
        workshopsArray.removeAll()
        
        let filename = "workshops"
        
        //Check if workshops.json exists
        let testRetrieve = JSONCache.getOptional(filename, as: JSON.self)
        if((testRetrieve) != nil){
            //load
            let jsonValue = JSON(testRetrieve!)
            //debugPrint("\(jsonValue)")
            for (_, subJson) in jsonValue[0]["data"]{
                
                self.workshopsArray.append(Workshop(workshopID: subJson["workshop_id"].intValue,
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
        
        //loadProfiles()
        
    }
    
    func checkSpeakers(){
        
        speakersArray.removeAll()
        let filename = "speakers"
        
        //Check if speaker.json exists
        let testRetrieve = JSONCache.getOptional(filename, as: JSON.self)
        if((testRetrieve) != nil){
            //load
            let jsonValue = JSON(testRetrieve!)
            //debugPrint("\(jsonValue)")
            for (_, subJson) in jsonValue[0]["data"]{
                self.speakersArray.append((Speaker(speakerID: subJson["id"].intValue,
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
        
        //loadWorkshops()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if workshopsArray.isEmpty{
            return 0
        }
        else{
            return workshopsArray.count
            
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "WorkshopsTableViewCell", for: indexPath) as! WorkshopsTableViewCell
        
        //cell.moreOptionButton.addTarget(self, action: #selector(openPopover), for: .touchUpInside)
        cell.selectionStyle = .none
        
        if (!workshopsArray.isEmpty){
            let cellWorkshop = workshopsArray[indexPath.row]
            
            cell.workshopTitleLabel.text = cellWorkshop.workshopName
            
            for speaker in speakersArray{
                if(speaker.speakerID == cellWorkshop.workshopSpeakerID){
                    cell.facilitatorsNameLabel.text = speaker.name//(cellWorkshop.workshopSpeakerID)
                }
            }
            
            let data  = UserDefaults.standard.object(forKey: "userProfile") as! Data
            let loadedUser = NSKeyedUnarchiver.unarchiveObject(with: data) as! User
            
            let userProfile = profileArray.first(where: ({ (profileSearch: Profile) -> Bool in
                return profileSearch.profileID == loadedUser.userID
            }))
            
            cell.selectedWorkshopLabel.isHidden = true
            if(cellWorkshop.workshopID == userProfile?.firstWorkshop || cellWorkshop.workshopID == userProfile?.secondWorkshop){
                cell.selectedWorkshopLabel.isHidden = false
            }

            
            cell.dateTimeLocationLabel.text = cellWorkshop.workshopDate + " " + cellWorkshop.workshopTime + " / " +  cellWorkshop.workshopLocation
            cell.moreOptionButton.addTarget(self, action: #selector(openPopover), for: .touchUpInside)
            cell.moreOptionButton.tag = indexPath.row
        }
        
        return cell
    }
    
    @IBAction func openPopover(sender: UIButton!){
        debugPrint("\(String(describing: sender))")
        showPopOverMenu(fromView: sender, indexPath: sender.tag)
    }
    
    // MARK: Tableview Delegate
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //debugPrint("\(indexPath.row)")
        DispatchQueue.main.async {
            self.openWorkshopInfoView(indexPath: indexPath.row, isOutline: false);
        }
    }
    
}
