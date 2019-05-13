//
//  WorkshopsView.swift
//  iDiscipleApp
//
//  Created by Rick Roman on 28/01/2019.
//

import UIKit
import Popover

class WorkshopsView: UIView {
    
    var workshopsArray : [Workshop] = []
    var speakersArray : [Speaker] = []
    
    var selectedIndexPath : Int? = nil
    
    var shouldSetupConstraints = true
    let screenSize = UIScreen.main.bounds
    
    lazy var backgroundView: UIView = {
        let view = UIView.newAutoLayout()
        //view.backgroundColor = UIColor(red: 51/255, green: 51/255, blue: 51/255, alpha: 1)
        view.backgroundColor = .red
        view.autoSetDimension(.height, toSize: screenSize.height)
        
        return view
    }()
    
    lazy var refreshControl = UIRefreshControl()
    
    lazy var workshopTableView : UITableView = {
        let tableView = UITableView.newAutoLayout()
        tableView.autoSetDimensions(to: CGSize(width: screenSize.width, height: screenSize.height))
        tableView.separatorStyle = .none
        
        tableView.rowHeight = 120
        
        return tableView
    }()
    
    lazy var workshopPopOverView : WorkshopPopOverView = {
        let view = WorkshopPopOverView(frame: CGRect(x: 0, y: 0, width: 210, height: 80))
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
        
        backgroundView.addSubview(workshopTableView)
        
        if #available(iOS 10.0, *) {
            workshopTableView.refreshControl = refreshControl
        } else {
            workshopTableView.addSubview(refreshControl)
        }
        
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
}
