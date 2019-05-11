//
//  MainTabBarController.swift
//  iDiscipleApp
//
//  Created by Rick Roman on 02/01/2019.
//

import UIKit
import SwiftyJSON
import Kingfisher

class CustomNavItemButton: UIButton {
    var alignmentRectInsetsOverride: UIEdgeInsets?
    override var alignmentRectInsets: UIEdgeInsets {
        return alignmentRectInsetsOverride ?? super.alignmentRectInsets
    }
}

class MainTabBarController: UITabBarController {
    
    var profileArray : [Profile] = []
    
    let speakersViewController = SpeakersViewController()
    let workshopsViewController = WorkshopsViewController()
    let scheduleViewController = ScheduleViewController()
    let communityViewController = CommunityViewController()
    let moreViewController = MoreViewController()
    
    let profileViewController = YourProfileViewController()

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.navigationController?.isNavigationBarHidden = false
        
        self.delegate = self as? UITabBarControllerDelegate
        //self.tabBarController?.delegate = self
        
        customizeNavigationBar()
        
        //Color of first selection
        self.tabBar.tintColor = UIColor(red: 243/255, green: 137/255, blue: 49/255, alpha: 1)
        self.navigationController?.navigationBar.barTintColor = UIColor(red: 243/255, green: 137/255, blue: 49/255, alpha: 1)
        
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
        
        //NotificationCenter.defaultCenter.addObserver(self, selector: "refreshList:", name:"refresh", object: nil)
        
        loadJsonFiles()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        debugPrint("TAB SHOW")
    }
    
    //Tab Bar Controller Delegate
    override func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
        //customizeNavigationBar()
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
        
//        let data  = UserDefaults.standard.object(forKey: "userProfile") as! Data
//        let loadedUser = NSKeyedUnarchiver.unarchiveObject(with: data) as! User
//
//        let profile = profileArray.first(where: ({(profileSearch: Profile) -> Bool in
//            return profileSearch.profileID == loadedUser.userID
//        }))
//        //debugPrint(profile?.profileID ?? nil as Any)
//        if(profile != nil){
//            if((profile?.imagePath.isEmpty)! && (profile?.imageName.isEmpty)!){
//                button.setImage(UIImage(named: "country_\(profile!.country)"), for: .normal)
//            }else{
//                let imageUrl = profile!.imagePath + profile!.imageName
//                debugPrint(imageUrl)
//                debugPrint("country_\(profile!.country)")
//                //button.imageView?.kf.indicatorType = .activity
//                button.imageView?.kf.setImage(with: ImageResource(downloadURL: URL(string: imageUrl)!, cacheKey: imageUrl), placeholder: UIImage(named: "country_\(profile!.country)"))
//
//                //let image = ImageResource(downloadURL: URL(string: imageUrl)!, cacheKey: imageUrl)
//            }
//        }else{
//            button.setImage(image, for: .normal)
//        }
        
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
        logoButton.isEnabled = false
        navigationItem.leftBarButtonItem = logoButton
        
        let infoButton = UIBarButtonItem(image: UIImage(named: "infoIcon")?.withRenderingMode(.alwaysOriginal), style: .plain, target: self, action: #selector(openMapView(sender:)))
        
        let data  = UserDefaults.standard.object(forKey: "userProfile") as! Data
        let loadedUser = NSKeyedUnarchiver.unarchiveObject(with: data) as! User
        
        //let tempImageView = UIImageView()
        let profile = profileArray.first(where: ({(profileSearch: Profile) -> Bool in
            return profileSearch.profileID == loadedUser.userID
        }))
        
        let profileImageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 35, height: 35))
        
        profileImageView.backgroundColor = .darkGray
        profileImageView.layer.masksToBounds = false
        profileImageView.layer.cornerRadius = 35/2
        profileImageView.clipsToBounds = true
        
        if(profile != nil){
            let imageUrl = profile!.imagePath //+ profile!.imageName
            debugPrint(" >>>> \(imageUrl)")
            profileImageView.kf.indicatorType = .activity
            profileImageView.kf.setImage(with: ImageResource(downloadURL: URL(string: imageUrl)!, cacheKey: imageUrl), placeholder: UIImage(named:"country_\(loadedUser.country)"))
        }else{
            profileImageView.image = UIImage(named:"country_\(loadedUser.country)")
        }
    
        profileImageView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(openProfileView(sender:))))
        //let customProfileBarButton = createCustomButton(offset: 0, image: ((image?.withRenderingMode(.alwaysOriginal))!))
        //customProfileBarButton.addTarget(self, action: #selector(openProfileView(sender:)), for: .touchUpInside)
        
        let profileButton = UIBarButtonItem()
        profileButton.customView = profileImageView

        let currWidth = profileButton.customView?.widthAnchor.constraint(equalToConstant: 35)
        currWidth?.isActive = true
        let currHeight = profileButton.customView?.heightAnchor.constraint(equalToConstant: 35)
        currHeight?.isActive = true
   
        navigationItem.rightBarButtonItems = [profileButton, infoButton]
        
    }
    
    @objc func openProfileView(sender: UIBarButtonItem){
        
        DispatchQueue.main.async {
            
//            let newViewController = YourProfileViewController()
//            //self.navigationController?.modal(newViewController, animated: false)
//            newViewController.modalPresentationStyle = .overFullScreen
//            self.present(newViewController, animated: false, completion: nil)
            
            //
            let newViewController = YourProfileViewController()
            newViewController.modalPresentationStyle = .overFullScreen
            newViewController.callbackClosure = { [weak self] in
                debugPrint("Reload Navigation")
                self?.loadProfiles()
            }
            newViewController.callbackLogout = { [weak self] in
                self?.logoutFromTabView()
            }
            self.present(newViewController, animated: false, completion: nil)
            //
        }
    }
    
    func logoutFromTabView(){
          debugPrint("Logout from Tab")
        self.navigationController?.popViewController(animated: false)
    }
    
    @objc func openMapView(sender: UIBarButtonItem){
        
        DispatchQueue.main.async {
            let newViewController = MapViewController()
            //self.navigationController?.modal(newViewController, animated: false)
            newViewController.profileArray = self.profileArray
            newViewController.modalPresentationStyle = .overFullScreen
            let nc = UINavigationController(rootViewController: newViewController)
            //nc.navigationController = self.navigationController
            self.present(nc, animated: false, completion: nil)
            //self.navigationController?.pushViewController(newViewController, animated: false)
        }
        
    }
    
    func loadJsonFiles(){
        
        var urlString = ApiManager.sharedInstance.baseURL + ApiManager.sharedInstance.loadData + "?user_id=" + "\(1)"
        //Test Check for loaded Api_Token
        if let data = UserDefaults.standard.data(forKey: "userProfile"),
            let user = NSKeyedUnarchiver.unarchiveObject(with: data) as? User{
            //debugPrint("Loaded User Token: \(user.token)")
            urlString = ApiManager.sharedInstance.baseURL + ApiManager.sharedInstance.loadData + "?user_id=" + "\(user.userID)"
        } else {
            print("There is an issue")
        }
        
        debugPrint(urlString)
        //change value to user logged
        //let urlString = ApiManager.sharedInstance.baseURL + ApiManager.sharedInstance.loadData + "?user_id" + "\(1)"
        
        ApiManager.sharedInstance.getDataWithRequest(requestUrl: urlString, onSuccess: { json in
            DispatchQueue.main.async {
                
                //self.appHelper.dismissAlert()
                
                let jsonValue = JSON(json)
                //debugPrint("\(jsonValue["data"])")
                
                //debugPrint("\(jsonValue["data"]["assets"]["speakers"]["path_file"])")
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
                
                let familyGroupPathFile = jsonValue["data"]["assets"]["family_groups"]["path_file"].stringValue
                self.loadJsonData(urlString: familyGroupPathFile, fileName: "family_groups")
                
//                debugPrint("\(jsonValue["data"]["assets"]["resources"])")
//                debugPrint("\(jsonValue["data"]["assets"]["about"])")
            }
        }, onFailure: { error in
            debugPrint("\(error)")
        })
    }
    
    func loadJsonData(urlString: String, fileName: String){
        
        //Check if speaker.json exists
        //let testRetrieve = JSONCache.getOptional(fileName, as: JSON.self)
        //if((testRetrieve) == nil){
            //save
            ApiManager.sharedInstance.getDataFromJson(url: urlString, onSuccess: { json in
                DispatchQueue.main.async {
                    
                    let jsonValue = JSON(json)
                    JSONCache.set(jsonValue, as: fileName)
                    
                }
            }, onFailure: { error in
                debugPrint("\(error)")
            })
        //}
        
        if(fileName == "speakers"){
            self.speakersViewController.loadSpeakers()
        }
        
        //Check if profile
        if(fileName == "profile"){
            loadProfiles()
        }
        
    }
    
    func loadProfiles(){
        
        profileArray.removeAll()
        
        let filename = "profile"
        
        //Check if profile.json exists
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
        
        customizeNavigationBar()
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
