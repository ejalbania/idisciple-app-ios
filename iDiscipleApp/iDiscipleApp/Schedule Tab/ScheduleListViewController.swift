//
//  ScheduleListViewController.swift
//  iDiscipleApp
//
//  Created by Rick Roman on 26/04/2019.
//

import UIKit
import XLPagerTabStrip

class ScheduleListViewController: UIViewController, IndicatorInfoProvider {

    var scheduleListView: ScheduleListView!
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
      
        scheduleListView = ScheduleListView(frame: CGRect.zero)
        self.view.addSubview(scheduleListView)
        
        scheduleListView.scheduleListTableView.contentInsetAdjustmentBehavior = .never

        // AutoLayout
        scheduleListView.autoPinEdgesToSuperviewEdges(with: UIEdgeInsets.zero)
        
  
        
    }
    
    // MARK: - IndicatorInfoProvider
    
    func indicatorInfo(for pagerTabStripController: PagerTabStripViewController) -> IndicatorInfo {
        return itemInfo
    }

}
