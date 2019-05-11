//
//  MoreViewController.swift
//  iDiscipleApp
//
//  Created by Rick Roman on 10/05/2019.
//

import UIKit
import XLPagerTabStrip
import SwiftyJSON

class MoreViewController: ButtonBarPagerTabStripViewController {
    
    var moreView: MoreView!
    var isReload = false

    override func viewDidLoad() {
        
        moreView = MoreView(frame: CGRect.zero)
        self.view.addSubview(moreView)
        
        // AutoLayout
        moreView.autoPinEdgesToSuperviewEdges(with: UIEdgeInsets.zero)
        
        self.containerView = moreView.scrollView
        self.buttonBarView = moreView.buttonBarView
        
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
        
        //temp disabled scroll
        containerView.isScrollEnabled = false
        
        changeCurrentIndexProgressive = {(oldCell: ButtonBarViewCell?, newCell: ButtonBarViewCell?, progressPercentage: CGFloat, changeCurrentIndex: Bool, animated: Bool) -> Void in
            guard changeCurrentIndex == true else { return }
            oldCell?.label.textColor = .lightGray
            newCell?.label.textColor = .black
        }
        
        
        super.viewDidLoad()
    }
    
    override func viewControllers(for pagerTabStripController: PagerTabStripViewController) -> [UIViewController] {
        
        let aboutVC = AboutViewController(itemInfo: "ABOUT")
        //        let child_1 = ScheduleListViewController(itemInfo: "2019-05-21")
        
        guard isReload else {
            return [aboutVC]
        }
        
        var childViewControllers = [aboutVC]
        
        for index in childViewControllers.indices {
            let nElements = childViewControllers.count - index
            let n = (Int(arc4random()) % nElements) + index
            if n != index {
                childViewControllers.swapAt(index, n)
            }
        }
        let nItems = 1 + (arc4random() % 8)
        return Array(childViewControllers.prefix(Int(nItems)))
    }
    
    override func reloadPagerTabStripView() {
        isReload = true
        if arc4random() % 2 == 0 {
            pagerBehaviour = .progressive(skipIntermediateViewControllers: arc4random() % 2 == 0, elasticIndicatorLimit: arc4random() % 2 == 0 )
        } else {
            pagerBehaviour = .common(skipIntermediateViewControllers: arc4random() % 2 == 0)
        }
        super.reloadPagerTabStripView()
    }
    
    override func configureCell(_ cell: ButtonBarViewCell, indicatorInfo: IndicatorInfo) {
        super.configureCell(cell, indicatorInfo: indicatorInfo)
        cell.backgroundColor = .clear
    }

}
