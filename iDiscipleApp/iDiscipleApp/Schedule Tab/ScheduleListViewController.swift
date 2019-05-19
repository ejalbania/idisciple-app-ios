//
//  ScheduleListViewController.swift
//  iDiscipleApp
//
//  Created by Rick Roman on 26/04/2019.
//

import UIKit
import XLPagerTabStrip
import SwiftyJSON

class ScheduleListViewController: DownloaderViewController, UITableViewDelegate, UITableViewDataSource, IndicatorInfoProvider {

    var scheduleListView: ScheduleListView!
    var itemInfo: IndicatorInfo = "View"
    
    var scheduleArray : [Schedule] = []
    
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
        
        scheduleListView.scheduleListTableView.delegate = self
        scheduleListView.scheduleListTableView.dataSource = self
        scheduleListView.scheduleListTableView.register(ScheduleTableViewCell.self, forCellReuseIdentifier: "ScheduleTableViewCell")
        
        scheduleListView.refreshControl.addTarget(self, action: #selector(reloadData(_:)), for: .valueChanged)
        
        loadSchedule()
        //debugPrint("\(String(describing: itemInfo.title))")
        
        //getSystemTime()
    }
    
    func getSystemTime(){
        
        debugPrint("\(GlobalConstant.kTimeSource_formatter.string(from: Date()))")
        debugPrint("\(GlobalConstant.kDateSource_formatter.string(from: Date()))")
        
    }
    
    @objc private func reloadData(_ sender: Any) {
        // Reload data
        debugPrint("call reload here")
        
        reloadJsonData(onSuccess: { string in
            
            DispatchQueue.main.async {
                self.doneReloading()
            }
            
            }, onFailure: { error in
                debugPrint(error)
                self.doneReloading()
        })
        
    }
    
    func doneReloading() {
        
        self.scheduleListView.refreshControl.endRefreshing()
        loadSchedule()
    }
    
    // MARK: - IndicatorInfoProvider
    
    func indicatorInfo(for pagerTabStripController: PagerTabStripViewController) -> IndicatorInfo {
        return itemInfo
    }
    
    func loadSchedule() {
        
        scheduleArray.removeAll()
        let filename = "schedule"
        
        //Check if schedule.json exists
        let testRetrieve = JSONCache.getOptional(filename, as: JSON.self)
        if((testRetrieve) != nil){
            //load
            let jsonValue = JSON(testRetrieve!)
            //debugPrint("\(jsonValue)")
            for (_, subJson) in jsonValue[0]["data"]{
                
                if(subJson["sched_date"].stringValue == itemInfo.title){
                    self.scheduleArray.append(Schedule(schedID: subJson["sched_id"].intValue,
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
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return scheduleArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ScheduleTableViewCell", for: indexPath) as! ScheduleTableViewCell
        
        cell.selectionStyle = .none
        
        if (!scheduleArray.isEmpty){
            let cellSchedule = scheduleArray[indexPath.row]
            
            cell.scheduleTimeLabel.text = cellSchedule.schedStartTime + " - " + cellSchedule.schedEndTime
            cell.eventNameLabel.text = cellSchedule.schedName
            cell.locationLabel.text = cellSchedule.schedVenue
            
            cell.happeningNowWorkshopLabel.isHidden = true
            cell.selectedWorkshopLabel.isHidden = true
            
            //Check here if workshop/happening or not
            let stringDay = GlobalConstant.kDateSource_formatter.string(from: Date())
            let currentDay = GlobalConstant.kDateSource_formatter.date(from: stringDay)
            let stringTime = GlobalConstant.kTimeSource_formatter.string(from: Date())
            let currentTime = GlobalConstant.kTimeSource_formatter.date(from: stringTime)
            let startTime = GlobalConstant.kTimeSource_formatter.date(from: cellSchedule.schedStartTime)
            let endTime = GlobalConstant.kTimeSource_formatter.date(from: cellSchedule.schedEndTime)
            
            //add date checking
            if(GlobalConstant.kDateSource_formatter.date(from: cellSchedule.schedDate)! == currentDay!){
                if startTime! < currentTime! && currentTime! < endTime!{
                    cell.happeningNowWorkshopLabel.isHidden = false
                }
            }
            
            //AddChecking if workshop
            //cell.selectedWorkshopLabel.isHidden = false
            //cell.happeningNowWorkshopLabel.isHidden = false
            
        }
        
        cell.shouldSetupConstraints = true
        cell.updateConstraints()
        
        return cell
    }


}
