//
//  MainTabBarController.swift
//  iDiscipleApp
//
//  Created by Rick Roman on 02/01/2019.
//

import UIKit

class MainTabBarController: UITabBarController {
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    // Do any additional setup after loading the view.
    self.navigationController?.isNavigationBarHidden = false
    
    let backButton = UIBarButtonItem(title: "", style: .plain, target: navigationController, action: nil)
    navigationItem.leftBarButtonItem = backButton
    
    self.delegate = self as? UITabBarControllerDelegate
    
    let speakersViewController = SpeakersViewController()
    let workshopsViewController = WorkshopsViewController()
    let scheduleViewController = ScheduleViewController()
    let communityViewController = CommunityViewController()
    let moreViewController = iDisciple.Story.more.initialViewController
    
    var icons = [
      UIImage(named: "tabIcon_speakers"),
      UIImage(named: "tabIcon_workshops"),
      UIImage(named: "tabIcon_schedule"),
      UIImage(named: "tabIcon_community"),
      UIImage(named: "tabIcon_more")
    ]
    icons.forEach { $0?.withRenderingMode(.alwaysTemplate) }
    
    speakersViewController.tabBarItem.image = icons[0]
    speakersViewController.tabBarItem.title = "Speakers"
    speakersViewController.tabBarItem.tag = 0
    
    workshopsViewController.tabBarItem.image = icons[1]
    workshopsViewController.tabBarItem.title = "Workshops"
    workshopsViewController.tabBarItem.tag = 1
    
    scheduleViewController.tabBarItem.image = icons[2]
    scheduleViewController.tabBarItem.title = "Schedule"
    scheduleViewController.tabBarItem.tag = 2
    
    communityViewController.tabBarItem.image = icons[3]
    communityViewController.tabBarItem.title = "Community"
    communityViewController.tabBarItem.tag = 3
    
    moreViewController.tabBarItem.tag = 4
    
    let controllers = [speakersViewController, workshopsViewController, scheduleViewController, communityViewController, moreViewController]
    self.viewControllers = controllers
    
  }
  
  override func viewDidAppear(_ animated: Bool) {
    super.viewDidAppear(animated)
    
    //Color of first selection
    self.tabBar.setTint(color: .orange)
    self.navigationController?.navigationBar.setBarTint(color: .orange)
    
  }
  
  //Tab Bar Controller Delegate
  override func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
    NSLog("%d", item.tag)
    
    var tabColor: iDisciple.Color {
      switch item.tag {
      case 0: return .orange
      case 1: return .green
      case 2: return .red
      case 3: return .blue
      case 4: fallthrough
      default: return .gray
      }
    }
    
    self.tabBar.setTint(color: tabColor)
    self.navigationController?.navigationBar.setBarTint(color: tabColor)
  }
  
}
extension UINavigationBar {
  @discardableResult
  func setBarTint(color: iDisciple.Color) -> Self {
    self.barTintColor = color.highlight
    return self
  }
}
