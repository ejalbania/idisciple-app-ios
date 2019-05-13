//
//  ScheduleViewController.swift
//  iDiscipleApp
//
//  Created by Rick Roman on 23/04/2019.
//

import UIKit
import XLPagerTabStrip
import SwiftyJSON

class ScheduleViewController: ButtonBarPagerTabStripViewController {

    var isReload = false
    var scheduleView: ScheduleView!
    
    //let blueInstagramColor = UIColor(red: 37/255.0, green: 111/255.0, blue: 206/255.0, alpha: 1.0)
    let day1VC = ScheduleListViewController(itemInfo: "2019-05-21")
    let day2VC = ScheduleListViewController(itemInfo: "2019-05-22")
    let day3VC = ScheduleListViewController(itemInfo: "2019-05-23")
    let day4VC = ScheduleListViewController(itemInfo: "2019-05-24")
    
    override func viewDidLoad() {
        
        scheduleView = ScheduleView(frame: CGRect.zero)
        self.view.addSubview(scheduleView)
        
        // AutoLayout
        scheduleView.autoPinEdgesToSuperviewEdges(with: UIEdgeInsets.zero)
        
        self.containerView = scheduleView.scrollView
        self.buttonBarView = scheduleView.buttonBarView
        
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
        
        super.viewDidLoad()
        checkDateForTabSelection()
    
        // Do any additional setup after loading the view.
        
    }
    
    func checkDateForTabSelection(){
        
        //Check here if workshop/happening or not
        let stringDay = GlobalConstant.kDateSource_formatter.string(from: Date())
        let currentDay = GlobalConstant.kDateSource_formatter.date(from: stringDay)
        
        let firstDay = GlobalConstant.kDateSource_formatter.date(from: day1VC.itemInfo.title!)
        let secondDay = GlobalConstant.kDateSource_formatter.date(from: day1VC.itemInfo.title!)
        let thirdDay = GlobalConstant.kDateSource_formatter.date(from: day1VC.itemInfo.title!)
        let lastDay = GlobalConstant.kDateSource_formatter.date(from: day1VC.itemInfo.title!)
        
        //add date checking
        if currentDay! <= firstDay!{
            moveToViewController(at: 0, animated: false)
            day1VC.scheduleListView.scheduleListTableView.reloadData()
        }
        if currentDay! > firstDay! && currentDay! == secondDay!{
            moveToViewController(at: 1, animated: false)
            day2VC.scheduleListView.scheduleListTableView.reloadData()
        }
        if currentDay! > secondDay! && currentDay! == thirdDay!{
            moveToViewController(at: 2, animated: false)
            day3VC.scheduleListView.scheduleListTableView.reloadData()
        }
        if currentDay! > thirdDay! && currentDay! == lastDay!{
            moveToViewController(at: 3, animated: false)
            day4VC.scheduleListView.scheduleListTableView.reloadData()
        }
        
        
    }
    
    // MARK: - PagerTabStripDataSource
    
    override func viewControllers(for pagerTabStripController: PagerTabStripViewController) -> [UIViewController] {
        
//        let child_1 = ScheduleListViewController(itemInfo: "2019-05-21")
//        let child_2 = ScheduleListViewController(itemInfo: "2019-05-22")
//        let child_3 = ScheduleListViewController(itemInfo: "2019-05-23")
//        let child_4 = ScheduleListViewController(itemInfo: "2019-05-24")
        //return [child_1, child_2, child_3, child_4]
        
        guard isReload else {
            return [day1VC, day2VC, day3VC, day4VC]
        }
        
        var childViewControllers = [day1VC, day2VC, day3VC, day4VC]
        
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
