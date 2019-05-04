//
//  MainTabBarController.swift
//  iDiscipleApp
//
//  Created by Rick Roman on 02/01/2019.
//

import UIKit
import SwiftyJSON

class CustomNavItemButton: UIButton {
    var alignmentRectInsetsOverride: UIEdgeInsets?
    override var alignmentRectInsets: UIEdgeInsets {
        return alignmentRectInsetsOverride ?? super.alignmentRectInsets
    }
}

class MainTabBarController: UITabBarController {
    
    let speakersViewController = SpeakersViewController()
    let workshopsViewController = WorkshopsViewController()
    let scheduleViewController = ScheduleViewController()
    let communityViewController = CommunityViewController()
    let moreViewController = ViewController()

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.navigationController?.isNavigationBarHidden = false
        
        customizeNavigationBar()
        
        self.delegate = self as? UITabBarControllerDelegate
        //self.tabBarController?.delegate = self
        
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
        
        loadJsonFiles()
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
            self.tabBar.tintColor = UIColor(red: 221/255, green: 36/255, blue: 58/255, alpha: 1)
            self.navigationController?.navigationBar.barTintColor = UIColor(red: 221/255, green: 36/255, blue: 58/255, alpha: 1)
            break
        case 3:
            self.tabBar.tintColor = UIColor(red: 22/255, green: 145/255, blue: 195/255, alpha: 1)
            self.navigationController?.navigationBar.barTintColor = UIColor(red: 22/255, green: 145/255, blue: 195/255, alpha: 1)
            break
        case 4:
            self.tabBar.tintColor = UIColor(red: 59/255, green: 59/255, blue: 59/255, alpha: 1)
            self.navigationController?.navigationBar.barTintColor = UIColor(red: 189/255, green: 189/255, blue: 189/255, alpha: 1)
            break
        default:
            self.tabBar.tintColor = UIColor(red: 243/255, green: 137/255, blue: 49/255, alpha: 1)
            self.navigationController?.navigationBar.barTintColor = UIColor(red: 243/255, green: 137/255, blue: 49/255, alpha: 1)
            break
        }
    }
    
    func createCustomButton(offset: CGFloat = 0, image: UIImage) -> UIButton {
        let button = CustomNavItemButton()
        button.alignmentRectInsetsOverride = UIEdgeInsets(top: 0, left: -offset, bottom: 0, right: offset)
        
        button.imageView?.backgroundColor = .darkGray
        button.imageView?.layer.masksToBounds = false
        button.imageView?.layer.cornerRadius = 35/2
        button.imageView?.clipsToBounds = true
        
        button.setImage(image, for: .normal)
        button.sizeToFit()
        button.contentMode = .scaleAspectFit

        
        //button.layer.borderWidth = 1.0
        //button.layer.borderColor = UIColor.black.cgColor
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }
    
    func customizeNavigationBar(){

        let logoButton = UIBarButtonItem(image: UIImage(named: "logoIcon_white")?.withRenderingMode(.alwaysOriginal), style: .plain, target: navigationController, action: nil)
        
        navigationItem.leftBarButtonItem = logoButton
        
        //let testCustomButton = UIBarButtonItem(customView: createCustomButton(offset: spacer.width))
        let infoButton = UIBarButtonItem(image: UIImage(named: "infoIcon")?.withRenderingMode(.alwaysOriginal), style: .plain, target: self, action: nil)
        
        let profileButton = UIBarButtonItem()
        let customProfileBarButton = createCustomButton(offset: 0, image: (UIImage(named:"creep")?.withRenderingMode(.alwaysOriginal))!)
        customProfileBarButton.addTarget(self, action: #selector(openProfileView(sender:)), for: .touchUpInside)
        
        profileButton.customView = customProfileBarButton

        let currWidth = profileButton.customView?.widthAnchor.constraint(equalToConstant: 35)
        currWidth?.isActive = true
        let currHeight = profileButton.customView?.heightAnchor.constraint(equalToConstant: 35)
        currHeight?.isActive = true
        
        //profileButton.customView?.layer.borderWidth = 1
   
        navigationItem.rightBarButtonItems = [profileButton, infoButton]
        
//        let profileButton = UIBarButtonItem(image: UIImage(named: "creep")?.withRenderingMode(.alwaysOriginal), style: .plain, target: navigationController, action: nil)
//        profileButton.customView?.layer.borderWidth = 1
//
//        navigationItem.rightBarButtonItems = [spacer, profileButton]
        
    }
    
    @objc func openProfileView(sender: UIBarButtonItem){
        
        DispatchQueue.main.async {
            let newViewController = YourProfileViewController()
            //self.navigationController?.modal(newViewController, animated: false)
            newViewController.modalPresentationStyle = .overFullScreen
            self.present(newViewController, animated: false, completion: nil)
        }
    }
    
    func loadJsonFiles(){
        
        //change value to user logged
        let urlString = ApiManager.sharedInstance.baseURL + ApiManager.sharedInstance.loadData + "?user_id" + "\(1)"
        
        ApiManager.sharedInstance.getDataWithRequest(requestUrl: urlString, onSuccess: { json in
            DispatchQueue.main.async {
                
                self.appHelper.dismissAlert()
                
                let jsonValue = JSON(json)
                //debugPrint("\(jsonValue["data"])")
                
                debugPrint("\(jsonValue["data"]["assets"]["speakers"]["path_file"])")
                let speakerPathFile = jsonValue["data"]["assets"]["speakers"]["path_file"].stringValue
                self.loadJsonData(urlString: speakerPathFile, fileName: "speakers")
                
                let workshopPathFile = jsonValue["data"]["assets"]["workshops"]["path_file"].stringValue
                self.loadJsonData(urlString: workshopPathFile, fileName: "workshops")
                
                let schedulePathFile = jsonValue["data"]["assets"]["schedule"]["path_file"].stringValue
                self.loadJsonData(urlString: schedulePathFile, fileName: "schedule")
                
                let countryPathFile = jsonValue["data"]["assets"]["countries"]["path_file"].stringValue
                self.loadJsonData(urlString: countryPathFile, fileName: "countries")
                
                let profilePathFile = jsonValue["data"]["assets"]["profile"]["path_file"].stringValue
                self.loadJsonData(urlString: profilePathFile, fileName: "profile")
                
//                debugPrint("\(jsonValue["data"]["assets"]["schedule"])")
//                debugPrint("\(jsonValue["data"]["assets"]["profile"])")
//                debugPrint("\(jsonValue["data"]["assets"]["family_groups"])")
//                debugPrint("\(jsonValue["data"]["assets"]["countries"])")
//                debugPrint("\(jsonValue["data"]["assets"]["resources"])")
//                debugPrint("\(jsonValue["data"]["assets"]["about"])")
                
            }
        }, onFailure: { error in
            debugPrint("\(error)")
        })
    }
    
    func loadJsonData(urlString: String, fileName: String){
        
        //Check if speaker.json exists
        let testRetrieve = JSONCache.getOptional(urlString, as: JSON.self)
        if((testRetrieve) == nil){
            //save
            ApiManager.sharedInstance.getDataFromJson(url: urlString, onSuccess: { json in
                DispatchQueue.main.async {
                    
                    let jsonValue = JSON(json)
                    JSONCache.set(jsonValue, as: fileName)
                    
                }
            }, onFailure: { error in
                debugPrint("\(error)")
            })
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
