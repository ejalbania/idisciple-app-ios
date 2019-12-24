//
//  CommunityViewController.swift
//  iDiscipleApp
//
//  Created by Rick Roman on 23/04/2019.
//

import UIKit
import Foundation
import XLPagerTabStrip
import SwiftyJSON

class CommunityViewController: ButtonBarPagerTabStripViewController {

  var communityView: CommunityView!

  var familyGroupArray : [FamilyGroup] = []
  var profileArray : [Profile] = []

  let groupVC = GroupsViewController(itemInfo: "GROUPS")
  let delegatesVC = DelegatesViewController(itemInfo: "DELEGATES")

  override func viewDidLoad() {

    settings.style.buttonBarBackgroundColor = .white
    settings.style.buttonBarItemBackgroundColor = .white
    settings.style.selectedBarBackgroundColor = .black
    settings.style.buttonBarItemFont = UIFont(name: "Montserrat-Bold", size: 24)!//.boldSystemFont(ofSize: 14)
    settings.style.selectedBarHeight = 0.0
    settings.style.buttonBarMinimumLineSpacing = 0
    settings.style.buttonBarItemTitleColor = .black
    settings.style.buttonBarItemsShouldFillAvailableWidth = true
    settings.style.buttonBarLeftContentInset = 0
    settings.style.buttonBarRightContentInset = 0

    changeCurrentIndexProgressive = {(oldCell: ButtonBarViewCell?, newCell: ButtonBarViewCell?, progressPercentage: CGFloat, changeCurrentIndex: Bool, animated: Bool) -> Void in
      guard changeCurrentIndex == true else { return }
      oldCell?.label.textColor = .lightGray
      newCell?.label.textColor = .black
    }

    communityView = CommunityView(frame: CGRect.zero)
    self.view.addSubview(communityView)

    self.buttonBarView = communityView.buttonBarView
    self.containerView = communityView.scrollView

    self.view.setNeedsLayout()
    // AutoLayout
    communityView.autoPinEdgesToSuperviewEdges(with: UIEdgeInsets.zero)

    loadCommunityData()

    groupVC.familyGroupArray = familyGroupArray
    groupVC.profileArray = profileArray
    delegatesVC.familyGroupArray = familyGroupArray
    delegatesVC.profileArray = profileArray

    super.viewDidLoad()

  }

  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)

    self.view.setNeedsLayout()
    //self.view.layoutIfNeeded()
  }

  func adjustViews(){
    DispatchQueue.main.async {
      self.view.setNeedsLayout()
    }
  }

  override func viewControllers(for pagerTabStripController: PagerTabStripViewController) -> [UIViewController] {
    return [groupVC, delegatesVC]
  }

  func loadCommunityData(){

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
      loadProfiles()

    }else{
      debugPrint("\(filename) not found!")
    }

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
  }
}
