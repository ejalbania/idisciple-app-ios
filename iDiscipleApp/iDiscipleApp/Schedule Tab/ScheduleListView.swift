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
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ScheduleTableViewCell", for: indexPath) as! ScheduleTableViewCell
        
        cell.selectionStyle = .none
  
        //cell.labMessage.text = "Message \(indexPath.row)"
        //cell.labTime.text = NSDateFormatter.localizedStringFromDate(NSDate(), dateStyle: .ShortStyle, timeStyle: .ShortStyle)
        
        return cell
    }

}
