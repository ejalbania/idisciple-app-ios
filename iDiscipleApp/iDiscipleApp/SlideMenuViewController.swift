//
//  SlideMenuViewController.swift
//  iDiscipleApp
//
//  Created by Rick Roman on 22/10/2018.
//

import UIKit

class SlideMenuViewController: UIViewController {
    
    var slideMenu: SlideMenuView!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        self.navigationController?.isNavigationBarHidden = true
        
        slideMenu = SlideMenuView(frame: CGRect.zero)
        self.view.addSubview(slideMenu)
        
        // AutoLayout
        slideMenu.autoPinEdgesToSuperviewEdges(with: UIEdgeInsets.zero)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        //self.navigationController?.isNavigationBarHidden = true
    }
    

}
