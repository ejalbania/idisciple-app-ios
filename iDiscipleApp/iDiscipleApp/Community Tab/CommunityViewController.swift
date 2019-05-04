//
//  CommunityViewController.swift
//  iDiscipleApp
//
//  Created by Rick Roman on 23/04/2019.
//

import UIKit
import Foundation
import XLPagerTabStrip

class CommunityViewController: ButtonBarPagerTabStripViewController {

    var communityView: CommunityView!
    
    //let blueInstagramColor = UIColor(red: 37/255.0, green: 111/255.0, blue: 206/255.0, alpha: 1.0)
    
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
        
        //communityView.scrollView.contentInsetAdjustmentBehavior = .never
        
        self.buttonBarView = communityView.buttonBarView
        self.containerView = communityView.scrollView
        
        self.view.setNeedsLayout()
        // AutoLayout
       communityView.autoPinEdgesToSuperviewEdges(with: UIEdgeInsets.zero)
        
        super.viewDidLoad()
        
        //adjustViews()

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
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    
    // MARK: - PagerTabStripDataSource
    
    override func viewControllers(for pagerTabStripController: PagerTabStripViewController) -> [UIViewController] {
        let child_1 = GroupsViewController(itemInfo: "GROUPS")
        let child_2 = DelegatesViewController(itemInfo: "DELEGATES")
        return [child_1, child_2]
    }

}
