//
//  GroupView.swift
//  iDiscipleApp
//
//  Created by Rick Roman on 27/04/2019.
//

import UIKit

class GroupsView: UIView {

    var shouldSetupConstraints = true
    let screenSize = UIScreen.main.bounds
    
    var familyGroupArray : [FamilyGroup] = []
    
    //var profileArray : [Profile] = []
    //var familyGroupListArray: [Profile] = []
    
    lazy var refreshControl = UIRefreshControl()
    
    lazy var mainView: UIView = {
        let view = UIView.newAutoLayout()
        view.backgroundColor = UIColor.white
        view.autoSetDimension(.height, toSize: screenSize.height)
        
        return view
    }()
    
    lazy var familyGroupNumberView: UIView = {
        let view = UIView.newAutoLayout()
        view.backgroundColor = .white
        //view.layer.borderWidth = 0.5
        view.autoSetDimension(.height, toSize: 150)
        view.autoSetDimension(.width, toSize: self.screenSize.width)
        
        return view
    }()
    
    lazy var familyGroupNumberLabel: UILabel = {
        let label = UILabel.newAutoLayout()
        label.text = "00"
        label.textColor = UIColor(red: 22/255, green: 145/255, blue: 195/255, alpha: 1)
        label.textAlignment = .center
        label.font = UIFont(name: "Montserrat-Bold", size: 90)
        label.numberOfLines = 1
        
        return label
    }()
    
    lazy var familyGroupLabel: UILabel = {
        let label = UILabel.newAutoLayout()
        label.text = "FAMILY GROUP #00"
        label.textColor = UIColor(red: 22/255, green: 145/255, blue: 195/255, alpha: 1)
        label.textAlignment = .center
        label.font = UIFont(name: "Montserrat-Bold", size: 22)
        label.numberOfLines = 1
        
        return label
    }()
    
    lazy var tensIncrementButton : UIButton = {
        let button = UIButton(type: UIButton.ButtonType.custom) as UIButton
        button.autoSetDimension(.height, toSize: 50)
        button.autoSetDimension(.width, toSize: 50)
        button.setImage(UIImage(named: "upArrow_enabled"), for: .normal)
        button.setImage(UIImage(named: "upArrow_disabled"), for: .disabled)
        
        return button
    }()
    
    lazy var tensDecrementButton : UIButton = {
        let button = UIButton(type: UIButton.ButtonType.custom) as UIButton
        button.autoSetDimension(.height, toSize: 50)
        button.autoSetDimension(.width, toSize: 50)
        button.setImage(UIImage(named: "downArrow_enabled"), for: .normal)
        button.setImage(UIImage(named: "downArrow_disabled"), for: .disabled)
        
        return button
    }()
    
    lazy var onesIncrementButton : UIButton = {
        let button = UIButton(type: UIButton.ButtonType.custom) as UIButton
        button.autoSetDimension(.height, toSize: 50)
        button.autoSetDimension(.width, toSize: 50)
        button.setImage(UIImage(named: "upArrow_enabled"), for: .normal)
        button.setImage(UIImage(named: "upArrow_disabled"), for: .disabled)
        
        return button
    }()
    
    lazy var onesDecrementButton : UIButton = {
        let button = UIButton(type: UIButton.ButtonType.custom) as UIButton
        button.autoSetDimension(.height, toSize: 50)
        button.autoSetDimension(.width, toSize: 50)
        button.setImage(UIImage(named: "downArrow_enabled"), for: .normal)
        button.setImage(UIImage(named: "downArrow_disabled"), for: .disabled)
        
        return button
    }()
    
    lazy var familyGroupTableView : UITableView = {
        let tableView = UITableView.newAutoLayout()
        tableView.backgroundColor = .white
        
        var tabOffset = 0
        debugPrint(self.screenSize.height)
        //896 xs, xr,
        //812 x, xs
        //736 6+
        //667 6
        if(screenSize.height >= 812){
            tabOffset = 226
        }else{
            tabOffset = 166
        }
        
        //tableView.autoSetDimensions(to: CGSize(width: screenSize.width, height: screenSize.height - CGFloat(tabOffset)))
        
        tableView.autoSetDimensions(to: CGSize(width: screenSize.width, height: screenSize.height-(CGFloat(tabOffset)+150)))
        tableView.separatorStyle = .none
        
        tableView.rowHeight = 100
        
        return tableView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.addSubview(mainView)
        
        mainView.addSubview(familyGroupNumberView);
        
        familyGroupNumberView.addSubview(familyGroupNumberLabel)
        familyGroupNumberView.addSubview(tensIncrementButton)
        familyGroupNumberView.addSubview(tensDecrementButton)
        
        familyGroupNumberView.addSubview(onesIncrementButton)
        familyGroupNumberView.addSubview(onesDecrementButton)
        
        familyGroupNumberView.addSubview(familyGroupLabel)
        
        mainView.addSubview(familyGroupTableView)
        
        
        if #available(iOS 10.0, *) {
            familyGroupTableView.refreshControl = refreshControl
        } else {
            familyGroupTableView.addSubview(refreshControl)
        }
        
        //familyGroupTableView.isHidden = true
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
            
            familyGroupNumberView.autoPinEdge(toSuperviewEdge: .left, withInset: 0)
            familyGroupNumberView.autoPinEdge(toSuperviewEdge: .top, withInset: 1)
            
            familyGroupNumberLabel.autoAlignAxis(toSuperviewAxis: .vertical)
            
            tensIncrementButton.autoPinEdge(toSuperviewEdge: .left, withInset: 20)
            tensIncrementButton.autoPinEdge(toSuperviewEdge: .top, withInset:30)
            
            tensDecrementButton.autoPinEdge(.left, to: .right, of: tensIncrementButton, withOffset: 5)
            tensDecrementButton.autoPinEdge(toSuperviewEdge: .top, withInset:30)
            
            onesIncrementButton.autoPinEdge(toSuperviewEdge: .right, withInset: 20)
            onesIncrementButton.autoPinEdge(toSuperviewEdge: .top, withInset:30)

            onesDecrementButton.autoPinEdge(.right, to: .left, of: onesIncrementButton, withOffset: -5)
            onesDecrementButton.autoPinEdge(toSuperviewEdge: .top, withInset:30)
            
            familyGroupLabel.autoAlignAxis(toSuperviewAxis: .vertical)
            familyGroupLabel.autoPinEdge(toSuperviewEdge: .bottom, withInset: 10)
            
            familyGroupTableView.autoPinEdge(.top, to: .bottom, of: familyGroupNumberView, withOffset: 0)
            
            shouldSetupConstraints = false
        }
        super.updateConstraints()
    }
}
