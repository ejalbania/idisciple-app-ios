//
//  ScheduleListViewController.swift
//  iDiscipleApp
//
//  Created by Rick Roman on 26/04/2019.
//

import UIKit
import XLPagerTabStrip
import SwiftyJSON

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
        
        loadSchedule()
        //debugPrint("\(String(describing: itemInfo.title))")
        //getSystemTime()
    }
    
    func getSystemTime(){
        
        debugPrint("\(GlobalConstant.kTimeSource_formatter.string(from: Date()))")
        debugPrint("\(GlobalConstant.kDateSource_formatter.string(from: Date()))")
        
    }
    
    // MARK: - IndicatorInfoProvider
    
    func indicatorInfo(for pagerTabStripController: PagerTabStripViewController) -> IndicatorInfo {
        return itemInfo
    }
    
    func loadSchedule() {
        
        let filename = "schedule"
        
        //Check if schedule.json exists
        let testRetrieve = JSONCache.getOptional(filename, as: JSON.self)
        if((testRetrieve) != nil){
            //load
            let jsonValue = JSON(testRetrieve!)
            //debugPrint("\(jsonValue)")
            for (_, subJson) in jsonValue[0]["data"]{
                
                if(subJson["sched_date"].stringValue == itemInfo.title){
                    self.scheduleListView.scheduleArray.append(Schedule(schedID: subJson["sched_id"].intValue,
                                                                               schedDate: subJson["sched_date"].stringValue,
                                                                               schedStartTime: subJson["sched_start_time"].stringValue,
                                                                               schedEndTime: subJson["sched_end_time"].stringValue,
                                                                               schedName: subJson["sched_name"].stringValue,
                                                                               schedVenue: subJson["sched_venue"].stringValue,
                                                                               schedWorkshopID: subJson["workshop_id"].intValue))
                }
            }
            
            //reloadTables
            self.scheduleListView.scheduleListTableView.reloadData()
            
        }else{
            debugPrint("\(filename) not found!")
        }
        
    }


}
