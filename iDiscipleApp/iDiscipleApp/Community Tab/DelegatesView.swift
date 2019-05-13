//
//  DelegatesView.swift
//  iDiscipleApp
//
//  Created by Rick Roman on 27/04/2019.
//

import UIKit

class DelegatesView: UIView {

    var shouldSetupConstraints = true
    let screenSize = UIScreen.main.bounds
    
    lazy var refreshControl = UIRefreshControl()
    
    lazy var mainView: UIView = {
        let view = UIView.newAutoLayout()
        view.backgroundColor = UIColor.gray
        view.autoSetDimension(.height, toSize: screenSize.height)
        
        return view
    }()
    
    lazy var searchBarView: UIView = {
        let view = UIView.newAutoLayout()
        view.backgroundColor = .white
        //view.layer.borderWidth = 0.5
        view.autoSetDimension(.height, toSize: 70)
        
        return view
    }()
    
    lazy var delegatesSearchBar : UISearchBar = {
        
        let search = UISearchBar.newAutoLayout()
        search.searchBarStyle = .minimal
        //search.layer.borderWidth = 1
        //search.layer.borderColor = UIColor.lightGray.cgColor
        //search.layer.cornerRadius = 5.0
        search.placeholder = "Search names"
        search.autoSetDimension(.height, toSize: 50)
        search.autoSetDimension(.width, toSize: self.screenSize.width - 40)
       
        return search
    }()
    
    lazy var onesDecrementButton : UIButton = {
        let button = UIButton(type: UIButton.ButtonType.custom) as UIButton
        button.autoSetDimension(.height, toSize: 50)
        button.autoSetDimension(.width, toSize: 50)
        button.setImage(UIImage(named: "downArrow_enabled"), for: .normal)
        button.setImage(UIImage(named: "downArrow_disabled"), for: .disabled)
        
        return button
    }()
    
    lazy var delegatesTableView : UITableView = {
        let tableView = UITableView.newAutoLayout()
        tableView.backgroundColor = .white
        tableView.autoSetDimensions(to: CGSize(width: screenSize.width, height: screenSize.height-(162+70)))
        tableView.separatorStyle = .none
        
        tableView.rowHeight = 100
        
        return tableView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.addSubview(mainView)
        
        mainView.addSubview(searchBarView)
        
        searchBarView.addSubview(delegatesSearchBar)
        
        mainView.addSubview(delegatesTableView)
        
        if #available(iOS 10.0, *) {
            delegatesTableView.refreshControl = refreshControl
        } else {
            delegatesTableView.addSubview(refreshControl)
        }
        
        //delegatesTableView.isHidden = true
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
            
            searchBarView.autoAlignAxis(toSuperviewAxis: .vertical)
            searchBarView.autoPinEdge(toSuperviewEdge: .left)
            searchBarView.autoPinEdge(toSuperviewEdge: .top, withInset: 1)
            
            delegatesSearchBar.autoAlignAxis(toSuperviewAxis: .vertical)
            delegatesSearchBar.autoAlignAxis(toSuperviewAxis: .horizontal)
            
            delegatesTableView.autoPinEdge(.top, to: .bottom, of: searchBarView, withOffset: 0)
            
            shouldSetupConstraints = false
        }
        super.updateConstraints()
    }
}
