//
//  ScheduleListView.swift
//  iDiscipleApp
//
//  Created by Rick Roman on 26/04/2019.
//

import UIKit

class ScheduleListView: UIView, UITableViewDelegate, UITableViewDataSource {
    
    var shouldSetupConstraints = true
    let screenSize = UIScreen.main.bounds
    
    var scheduleArray : [Schedule] = []

    lazy var mainView: UIView = {
        let view = UIView.newAutoLayout()
        view.backgroundColor = UIColor.white
        view.autoSetDimension(.height, toSize: screenSize.height)
        
        return view
    }()
    
    lazy var scheduleListTableView : UITableView = {
        let tableView = UITableView.newAutoLayout()
        tableView.backgroundColor = .white
        tableView.autoSetDimensions(to: CGSize(width: screenSize.width, height: screenSize.height-162))
        tableView.separatorStyle = .none
        
        tableView.rowHeight = 120
        
        return tableView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.addSubview(mainView)
        
        scheduleListTableView.delegate = self
        scheduleListTableView.dataSource = self
        scheduleListTableView.register(ScheduleTableViewCell.self, forCellReuseIdentifier: "ScheduleTableViewCell")
        mainView.addSubview(scheduleListTableView)
        
        //scheduleListTableView.isHidden = true
        //NSLog("%f", screenSize.height)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func updateConstraints() {
        if(shouldSetupConstraints) {
            
            // AutoLayout constraints
            //backgroundView.autoCenterInSuperview()
            
            mainView.autoPinEdge(toSuperviewEdge: .left)
            mainView.autoPinEdge(toSuperviewEdge: .right)
            mainView.autoPinEdge(toSuperviewEdge: .top)
            //mainView.autoPinEdge(toSuperviewEdge: .bottom)
            
            shouldSetupConstraints = false
        }
        super.updateConstraints()
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
