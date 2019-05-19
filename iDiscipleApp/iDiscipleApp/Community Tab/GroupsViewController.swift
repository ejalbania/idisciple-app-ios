//
//  GroupsViewController.swift
//  iDiscipleApp
//
//  Created by Rick Roman on 23/04/2019.
//

import UIKit
import XLPagerTabStrip
import SwiftyJSON
import Kingfisher

class GroupsViewController: DownloaderViewController, IndicatorInfoProvider, UITableViewDelegate, UITableViewDataSource {

    var groupsView: GroupsView!
    var itemInfo: IndicatorInfo = "View"
    
    var familyGroupCounter = 1
    
    var familyGroupArray : [FamilyGroup] = []
    var profileArray : [Profile] = []
    
    var familyGroupListArray: [Profile] = []
    
    init(itemInfo: IndicatorInfo) {
        self.itemInfo = itemInfo
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
  
        
        groupsView = GroupsView(frame: CGRect.zero)
        self.view.addSubview(groupsView)
        
        //groupsView.familyGroupTableView.contentInsetAdjustmentBehavior = .never
        
        // AutoLayout
        groupsView.autoPinEdgesToSuperviewEdges(with: UIEdgeInsets.zero)
        
        super.viewDidLoad()
        //self.view.setNeedsLayout()
        
        groupsView.familyGroupTableView.delegate = self
        groupsView.familyGroupTableView.dataSource = self
        groupsView.familyGroupTableView.register(DelegateTableViewCell.self, forCellReuseIdentifier: "DelegateTableViewCell")
        
        updateFamilyGroupCounter()
        
        groupsView.tensIncrementButton.addTarget(self, action: #selector(tensIncrementButtonPressed), for: .touchUpInside)
        groupsView.tensDecrementButton.addTarget(self, action: #selector(tensDecrementButtonPressed), for: .touchUpInside)
        groupsView.onesIncrementButton.addTarget(self, action: #selector(onesIncrementButtonPressed), for: .touchUpInside)
        groupsView.onesDecrementButton.addTarget(self, action: #selector(onesDecrementButtonPressed), for: .touchUpInside)
        
        groupsView.refreshControl.addTarget(self, action: #selector(reloadData(_:)), for: .valueChanged)

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
        
        self.groupsView.refreshControl.endRefreshing()
        updateFamilyGroupCounter()
    }
    
//    override func viewWillAppear(_ animated: Bool) {
//        super.viewWillAppear(animated)
//
//        self.view.setNeedsLayout()
//        //self.groupsView.familyGroupNumberView.setNeedsLayout()
//        //self.view.layoutIfNeeded()
//    }
    
    // MARK: - IndicatorInfoProvider
    
    func indicatorInfo(for pagerTabStripController: PagerTabStripViewController) -> IndicatorInfo {
        return itemInfo
    }
    
    
    // MARK: - TableView DataSource
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return familyGroupListArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "DelegateTableViewCell", for: indexPath) as! DelegateTableViewCell
        
        cell.selectionStyle = .none
        
        if (!familyGroupListArray.isEmpty){
            let cellProfile = familyGroupListArray[indexPath.row]
            
            cell.nicknameLabel.text = cellProfile.nickName
            
            let data  = UserDefaults.standard.object(forKey: "userProfile") as! Data
            let loadedUser = NSKeyedUnarchiver.unarchiveObject(with: data) as! User
            
            if(cellProfile.profileID == loadedUser.userID){
                cell.completeNameLabel.textColor = .orange
                cell.completeNameLabel.text = "That's You!"
            }else{
                cell.completeNameLabel.textColor = .gray
                cell.completeNameLabel.text = cellProfile.profileName
            }
            
            //check image
            if(cellProfile.imagePath.isEmpty && cellProfile.imageName.isEmpty){
                cell.delegateImageView.image = UIImage(named: "country_" + cellProfile.country)
            }else{
                let imageUrl = cellProfile.imagePath //+ cellProfile.imageName
                cell.delegateImageView.kf.indicatorType = .activity
                cell.delegateImageView.kf.setImage(with: ImageResource(downloadURL:URL(string: imageUrl)!, cacheKey: imageUrl), placeholder:  UIImage(named: "country_" + cellProfile.country))
            }
            
            //check if fg
            
            cell.leaderLabel.isHidden = true
            if(indexPath.row == 0){
                cell.leaderLabel.isHidden = false
            }
        }
        
        //cell.labMessage.text = "Message \(indexPath.row)"
        //cell.labTime.text = NSDateFormatter.localizedStringFromDate(NSDate(), dateStyle: .ShortStyle, timeStyle: .ShortStyle)
        
        return cell
    }
    
    func updateFamilyGroupCounter(){
        
        var counterText = "00"
        if familyGroupCounter < 10 {
            counterText = "0" + "\(familyGroupCounter)"
        } else{
            counterText = "\(familyGroupCounter)"
        }
        
        groupsView.familyGroupNumberLabel.text = counterText
        
        for familyGroup in familyGroupArray{
            //debugPrint("\(familyGroup.familyGroupID) : \(familyGroup.familyGroupName)")
            if(familyGroup.familyGroupID == familyGroupCounter){
                groupsView.familyGroupLabel.text = familyGroup.familyGroupName
            }
        }
        
        groupsView.tensIncrementButton.isEnabled = true
        groupsView.tensDecrementButton.isEnabled = true
        groupsView.onesIncrementButton.isEnabled = true
        groupsView.onesDecrementButton.isEnabled = true
        
        //If Family < 10 disable tens
        if (familyGroupArray.count < 10){
            groupsView.tensIncrementButton.isEnabled = false
            groupsView.tensDecrementButton.isEnabled = false
        }
        
        //If counter = count disable increment
        if (familyGroupCounter == familyGroupArray.count){
            groupsView.tensIncrementButton.isEnabled = false
            groupsView.onesIncrementButton.isEnabled = false
        }
        
        //If counter = 1 disable decrement
        if(familyGroupCounter == 1){
            groupsView.tensDecrementButton.isEnabled = false
            groupsView.onesDecrementButton.isEnabled = false
        }
        
        var checkCount = 0
        //If counter - 10 < 1
        checkCount = familyGroupCounter - 10
        if(checkCount < 1){
            groupsView.tensDecrementButton.isEnabled = false
        }
        
        //If counter + 10 > count
        checkCount = familyGroupCounter + 10
        if(checkCount > familyGroupArray.count){
            groupsView.tensIncrementButton.isEnabled = false
        }
        
        filterDisplayList()
    }
    
    @IBAction func tensIncrementButtonPressed(sender: UIButton!){
        debugPrint("tens ++")
        familyGroupCounter += 10
        updateFamilyGroupCounter()
        
    }
    
    @IBAction func tensDecrementButtonPressed(sender: UIButton!){
        debugPrint("tens --")
        familyGroupCounter -= 10
        updateFamilyGroupCounter()
        
    }
    
    @IBAction func onesIncrementButtonPressed(sender: UIButton!){
        debugPrint("ones ++")
        familyGroupCounter += 1
        updateFamilyGroupCounter()
    }
    
    @IBAction func onesDecrementButtonPressed(sender: UIButton!){
        debugPrint("ones --")
        familyGroupCounter -= 1
        updateFamilyGroupCounter()
        
    }
    
    func filterDisplayList(){
        
        familyGroupListArray.removeAll()
        
        for profile in profileArray{
            //debugPrint("\(familyGroup.familyGroupID) : \(familyGroup.familyGroupName)")
            if(profile.familyGroupID == familyGroupCounter){
                if(profile.profileID == familyGroupArray[familyGroupCounter-1].familyGroupLeadID){
                       familyGroupListArray.insert(profile, at: 0)
                }else{
                       familyGroupListArray.append(profile)
                }
            }
        }
        groupsView.familyGroupTableView.reloadData()
        
    }
}
