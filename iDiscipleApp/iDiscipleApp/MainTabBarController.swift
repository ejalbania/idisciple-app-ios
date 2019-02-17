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
        
        //Test hide button
        let backButton = UIBarButtonItem(title: "", style: .plain, target: navigationController, action: nil)
        navigationItem.leftBarButtonItem = backButton
        
        self.delegate = self as? UITabBarControllerDelegate
        //self.tabBarController?.delegate = self
        
        let speakersViewController = SpeakersViewController()
        
        let workshopsViewController = WorkshopsViewController()
        
        let scheduleViewController = ViewController()
        scheduleViewController.view.backgroundColor = UIColor.white
        
        let communityViewController = ViewController()
        communityViewController.view.backgroundColor = UIColor.white
        
        let moreViewController = ViewController()
        moreViewController.view.backgroundColor = UIColor.white
        
        //Color of first selection
        self.tabBar.tintColor = UIColor(red: 243/255, green: 137/255, blue: 49/255, alpha: 1)
        
        speakersViewController.tabBarItem.image = UIImage(named: "tabIcon_speakers")?.withRenderingMode(UIImage.RenderingMode.alwaysTemplate)
        speakersViewController.tabBarItem.title = "Speakers"
        speakersViewController.tabBarItem.tag = 0
        
        workshopsViewController.tabBarItem.image = UIImage(named: "tabIcon_workshops")?.withRenderingMode(UIImage.RenderingMode.alwaysTemplate)
        workshopsViewController.tabBarItem.title = "Workshops"
        workshopsViewController.tabBarItem.tag = 1
 
        scheduleViewController.tabBarItem.image = UIImage(named: "tabIcon_schedule")?.withRenderingMode(UIImage.RenderingMode.alwaysTemplate)
        scheduleViewController.tabBarItem.title = "Schedule"
        scheduleViewController.tabBarItem.tag = 2
        
        communityViewController.tabBarItem.image = UIImage(named: "tabIcon_community")?.withRenderingMode(UIImage.RenderingMode.alwaysTemplate)
        communityViewController.tabBarItem.title = "Community"
        communityViewController.tabBarItem.tag = 3
        
        moreViewController.tabBarItem.image = UIImage(named: "tabIcon_more")?.withRenderingMode(UIImage.RenderingMode.alwaysTemplate)
        moreViewController.tabBarItem.title = "More"
        moreViewController.tabBarItem.tag = 4
        
        let controllers = [speakersViewController, workshopsViewController, scheduleViewController, communityViewController, moreViewController]
        self.viewControllers = controllers
        //self.viewControllers = controllers.map { UINavigationController(rootViewController: $0)}
        
        //tabBarController?.selectedViewController = speakersViewController;
    }
    
    //Tab Bar Controller Delegate
    override func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
        NSLog("%d", item.tag);
        switch item.tag {
        case 0:
             self.tabBar.tintColor = UIColor(red: 243/255, green: 137/255, blue: 49/255, alpha: 1)
             self.navigationController?.navigationBar.barTintColor = UIColor(red: 243/255, green: 137/255, blue: 49/255, alpha: 1)
            break
        case 1:
            self.tabBar.tintColor = UIColor(red: 101/255, green: 175/255, blue: 85/255, alpha: 1)
            self.navigationController?.navigationBar.barTintColor = UIColor(red: 101/255, green: 175/255, blue: 85/255, alpha: 1)
            break
        case 2:
            self.tabBar.tintColor = UIColor(red: 220/255, green: 36/255, blue: 58/255, alpha: 1)
            break
        case 3:
            self.tabBar.tintColor = UIColor(red: 22/255, green: 145/255, blue: 195/255, alpha: 1)
            break
        case 4:
            self.tabBar.tintColor = UIColor(red: 59/255, green: 59/255, blue: 59/255, alpha: 1)
            break
        default:
            self.tabBar.tintColor = UIColor(red: 243/255, green: 137/255, blue: 49/255, alpha: 1)
            break
        }
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
