//
//  DashboardViewController.swift
//  iDiscipleApp
//
//  Created by PCCWS User2 on 11/10/2018.
//

import UIKit
import SideMenu

class DashboardViewController: UIViewController {
    
    var dashboadView: DashboardView!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        //Set
        self.navigationController?.isNavigationBarHidden = false
        self.navigationItem.title = "Dashboard"
        self.navigationController?.navigationBar.barTintColor = .white
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor:UIColor(red: 130/255, green: 130/255, blue: 130/255, alpha: 1), NSAttributedString.Key.font: UIFont(name: "Montserrat-Bold", size: 20)!]
        
        let menuBtnItem = UIBarButtonItem(image: UIImage(named: "dash_menu"), style: UIBarButtonItem.Style.plain, target: self, action: #selector(menuButtonPressed))
        menuBtnItem.tintColor = UIColor(red: 130/255, green: 130/255, blue: 130/255, alpha: 1)
        
        
        self.navigationItem.leftBarButtonItem = menuBtnItem
        
        let aboutBtnItem = UIButton(frame: CGRect(x: 0, y: 0, width: 10, height: 10))
        aboutBtnItem.setBackgroundImage(UIImage(named: "dash_about"), for: .normal)
        aboutBtnItem.imageView?.contentMode = .scaleAspectFit
        aboutBtnItem.addTarget(self, action: #selector(aboutButtonPressed), for: .touchUpInside)
        
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(customView: aboutBtnItem)

        dashboadView = DashboardView(frame: CGRect.zero)
        self.view.addSubview(dashboadView)
        
        let slideMenuViewController = SlideMenuViewController()
        
        let menuLeftViewController = UISideMenuNavigationController(rootViewController: slideMenuViewController)
        SideMenuManager.default.menuLeftNavigationController = menuLeftViewController
        SideMenuManager.default.menuPresentMode = .menuSlideIn
        SideMenuManager.default.menuAnimationBackgroundColor = .clear
        
        // AutoLayout
        dashboadView.autoPinEdgesToSuperviewEdges(with: UIEdgeInsets.zero)
        
        //Test Check for loaded Api_Token
        if let data = UserDefaults.standard.data(forKey: "userProfile"),
            let user = NSKeyedUnarchiver.unarchiveObject(with: data) as? User{
            debugPrint("Loaded User Token: \(user.token)")
        } else {
            print("There is an issue")
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        //self.navigationController?.isNavigationBarHidden = true
    }
    
    @objc func menuButtonPressed() {
        
        debugPrint("OPEN SLIDE MENU")
        present(SideMenuManager.default.menuLeftNavigationController!, animated: true, completion: nil)
    }
    
    @objc func aboutButtonPressed() {
        debugPrint("OPEN About")
    }

}
