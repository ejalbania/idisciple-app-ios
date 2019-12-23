//
//  HomeViewController.swift
//  iDiscipleApp
//
//  Created by eboy on 11/09/2018.
//

import UIKit

class HomeViewController: UIViewController {

    var homeView: HomeView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        //btn1.addTarget(self, action: #selector(Class.Methodname), for: .touchUpInside)
       
        homeView = HomeView(frame: CGRect.zero)
        self.view.addSubview(homeView)
        
        let item1 = UIBarButtonItem(customView: homeView.menuBtn)
        self.navigationItem.setLeftBarButtonItems([item1], animated: true)
        
        homeView.navBarHeight = CGFloat((navigationController?.navigationBar.frame.height)!);
        print(navigationController?.navigationBar.frame.height as Any)
        // AutoLayout
        homeView.autoPinEdgesToSuperviewEdges(with: UIEdgeInsets.zero)
        
        homeView.bannerView.image = UIImage(named: "banner")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        //self.navigationController?.isNavigationBarHidden = true
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
