//
//  GroupsViewController.swift
//  iDiscipleApp
//
//  Created by Rick Roman on 23/04/2019.
//

import UIKit
import XLPagerTabStrip

class GroupsViewController: UIViewController, IndicatorInfoProvider {

    var groupsView: GroupsView!
    var itemInfo: IndicatorInfo = "View"
    
    init(itemInfo: IndicatorInfo) {
        self.itemInfo = itemInfo
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        groupsView = GroupsView(frame: CGRect.zero)
        self.view.addSubview(groupsView)
        
        //groupView.familyGroupNumberLabel.contentInsetAdjustmentBehavior = .never
        
        // AutoLayout
        groupsView.autoPinEdgesToSuperviewEdges(with: UIEdgeInsets.zero)

    }
    
    // MARK: - IndicatorInfoProvider
    
    func indicatorInfo(for pagerTabStripController: PagerTabStripViewController) -> IndicatorInfo {
        return itemInfo
    }

}
