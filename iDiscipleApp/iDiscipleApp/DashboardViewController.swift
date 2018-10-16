//
//  DashboardViewController.swift
//  iDiscipleApp
//
//  Created by PCCWS User2 on 11/10/2018.
//

import UIKit

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
        
        dashboadView = DashboardView(frame: CGRect.zero)
        self.view.addSubview(dashboadView)
        
        // AutoLayout
        dashboadView.autoPinEdgesToSuperviewEdges(with: UIEdgeInsets.zero)
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
    }

}
