//
//  WorkshopsView.swift
//  iDiscipleApp
//
//  Created by Rick Roman on 28/01/2019.
//

import UIKit
import Popover

@objc protocol WorkshopsTableViewDelegate {
    @objc optional func workshopMoreOptionDidPressed(_ workshopsTableView: UITableView, selectedButton: UIButton) -> Void
    //func customAlertDidPressDismiss(_ customAlert: CustomAlertController) -> Void
    //@objc optional func customAlertDidPressOk(_ customAlert: CustomAlertController) -> Void
}

class WorkshopsView: UIView, UITableViewDelegate, UITableViewDataSource {
    
     var delegate : WorkshopsTableViewDelegate?
    
    var shouldSetupConstraints = true
    let screenSize = UIScreen.main.bounds
    
    lazy var backgroundView: UIView = {
        let view = UIView.newAutoLayout()
        //view.backgroundColor = UIColor(red: 51/255, green: 51/255, blue: 51/255, alpha: 1)
        view.backgroundColor = .red
        view.autoSetDimension(.height, toSize: screenSize.height)
        
        return view
    }()
    
    lazy var workshopTableView : UITableView = {
        let tableView = UITableView.newAutoLayout()
        tableView.autoSetDimensions(to: CGSize(width: screenSize.width, height: screenSize.height))
        tableView.separatorStyle = .none
        
        tableView.rowHeight = 120
        
        return tableView
    }()
    
    lazy var workshopPopOverView : WorkshopPopOverView = {
        let view = WorkshopPopOverView(frame: CGRect(x: 0, y: 0, width: 250, height: 80))
        return view
    }()
    
    lazy var popOver : Popover = {
        let options = [
            .cornerRadius(0),
            .animationIn(0.3),
            .animationOut(0.0),
            .arrowSize(CGSize.zero),
            .showBlackOverlay(true)
            ] as [PopoverOption]
        let popover = Popover(options: options, showHandler: nil, dismissHandler: nil)
        
        return popover
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.addSubview(backgroundView)
        
        workshopTableView.delegate = self
        workshopTableView.dataSource = self
        workshopTableView.register(WorkshopsTableViewCell.self, forCellReuseIdentifier: "WorkshopsTableViewCell")
        backgroundView.addSubview(workshopTableView)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func updateConstraints() {
        if(shouldSetupConstraints) {
            
            // AutoLayout constraints
            //backgroundView.autoCenterInSuperview()
            
            backgroundView.autoPinEdge(toSuperviewEdge: .left)
            backgroundView.autoPinEdge(toSuperviewEdge: .right)
            backgroundView.autoPinEdge(toSuperviewEdge: .bottom)
            
            shouldSetupConstraints = false
        }
        super.updateConstraints()
    }
    

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 7
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "WorkshopsTableViewCell", for: indexPath) as! WorkshopsTableViewCell
        
        cell.workshopTitleLabel.text = "Warding 101"

        cell.moreOptionButton.tag = indexPath.row
        cell.selectionStyle = .none
        cell.moreOptionButton.addTarget(self, action: #selector(openPopover), for: .touchUpInside)
        
        //cell.labUerName.text = "Name"
        //cell.labMessage.text = "Message \(indexPath.row)"
        //cell.labTime.text = NSDateFormatter.localizedStringFromDate(NSDate(), dateStyle: .ShortStyle, timeStyle: .ShortStyle)

        return cell
    }
    
    
    @IBAction func openPopover(sender: UIButton!){
        //debugPrint(sender.tag)
        delegate?.workshopMoreOptionDidPressed!(workshopTableView, selectedButton: sender)
    }
}
