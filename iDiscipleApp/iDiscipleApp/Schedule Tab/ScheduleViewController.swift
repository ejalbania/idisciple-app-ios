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
  let day1VC = ScheduleListViewController(itemInfo: "2019-12-26")
  let day2VC = ScheduleListViewController(itemInfo: "2019-12-27")
  let day3VC = ScheduleListViewController(itemInfo: "2019-12-28")

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

    // Do any additional setup after loading the view.
  }

  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)

    self.checkDateForTabSelection()
  }

  func checkDateForTabSelection(){

    //Check here if workshop/happening or not
    let stringDay = GlobalConstant.kDateSource_formatter.string(from: Date())

    day1VC.loadSchedule()

    if (stringDay == day1VC.itemInfo.title!){
      debugPrint("Day 1")
      moveToViewController(at: 0, animated: true)
      day1VC.loadSchedule()
    }
    if (stringDay == day2VC.itemInfo.title!){
      debugPrint("Day 2")
      moveToViewController(at: 1, animated: true)
      day2VC.loadSchedule()
    }
    if (stringDay == day3VC.itemInfo.title!){
      debugPrint("Day 3")
      moveToViewController(at: 2, animated: true)
      day3VC.loadSchedule()
    }
  }

  // MARK: - PagerTabStripDataSource

  override func viewControllers(for pagerTabStripController: PagerTabStripViewController) -> [UIViewController] {
    guard isReload else {
      return [day1VC, day2VC, day3VC]
    }

    var childViewControllers = [day1VC, day2VC, day3VC]

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
