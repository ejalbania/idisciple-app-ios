//
//  ScheduleTableViewCell.swift
//  iDiscipleApp
//
//  Created by Rick Roman on 27/04/2019.
//

import UIKit

class ScheduleTableViewCell: UITableViewCell {

    let screenSize = UIScreen.main.bounds
    var shouldSetupConstraints = true
    
    lazy var cellBackgroundView : UIView = {
        
        //var vFrame = self.frame.insetBy(dx: 3.0, dy: 3.0)
        //let view = UIView(frame: vFrame)
        let view = UIView.newAutoLayout()
        view.autoSetDimensions(to: CGSize(width: screenSize.width - 20, height: 110))
        
        view.backgroundColor = .clear
        
        //view.layer.cornerRadius = 5.0
        view.layer.borderColor = UIColor.lightGray.cgColor
        view.layer.borderWidth = 1.0
        //view.center = CGPoint(x: self.bounds.size.width * 0.5, y: self.bounds.size.height * 0.5)
        //view.backgroundColor = cellColorDefault
        
        return view
    }()
    
    lazy var eventNameLabel: UILabel = {
        let label = UILabel.newAutoLayout()
        //label.backgroundColor = .yellow
        label.text = "Event Name: Stuff Here"
        label.textColor = .black
        label.textAlignment = .left
        label.adjustsFontSizeToFitWidth = true
        label.font = UIFont(name: "Montserrat-Bold", size: 20)
        label.numberOfLines = 1
        return label
    }()
    
    lazy var scheduleTimeLabel: UILabel = {
        let label = UILabel.newAutoLayout()
        //label.backgroundColor = .yellow
        label.text = "0:00xx - 0:00xx"
        label.textColor = .gray
        label.textAlignment = .left
        label.font = UIFont(name: "Montserrat-Bold", size: 16)
        label.numberOfLines = 1
        return label
    }()
    
    lazy var locationLabel: UILabel = {
        let label = UILabel.newAutoLayout()
        //label.backgroundColor = .yellow
        label.text = "Venue Goes Here"
        label.textColor = .black
        label.textAlignment = .left
        label.font = UIFont(name: "Montserrat-Bold", size: 16)
        label.numberOfLines = 1
        return label
    }()
    
    lazy var selectedWorkshopLabel: UILabel = {
        let label = UILabel.newAutoLayout()
        //label.backgroundColor = .yellow
        label.text = "YOUR WORKSHOP"
        label.textColor = .orange
        label.textAlignment = .left
        label.font = UIFont(name: "Montserrat-Bold", size: 16)
        label.numberOfLines = 1
        return label
    }()
    
    lazy var happeningNowWorkshopLabel: UILabel = {
        let label = UILabel.newAutoLayout()
        //label.backgroundColor = .yellow
        label.text = "HAPPENING NOW"
        label.textColor = UIColor(red: 22/255, green: 145/255, blue: 195/255, alpha: 1)
        label.textAlignment = .left
        label.font = UIFont(name: "Montserrat-Bold", size: 16)
        label.numberOfLines = 1
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .default, reuseIdentifier: reuseIdentifier)
        
        //self.layer.borderColor = UIColor(red: 0/255, green: 84/255, blue: 151/255, alpha: 1).cgColor
        //self.layer.borderWidth = 0.5
        
        contentView.addSubview(cellBackgroundView)
        cellBackgroundView.addSubview(eventNameLabel)
        cellBackgroundView.addSubview(scheduleTimeLabel)
        cellBackgroundView.addSubview(locationLabel)
        
        cellBackgroundView.addSubview(selectedWorkshopLabel)
        selectedWorkshopLabel.isHidden = true
        cellBackgroundView.addSubview(happeningNowWorkshopLabel)
        happeningNowWorkshopLabel.isHidden = true
        
        self.setNeedsUpdateConstraints()
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        //cellBackgroundView.appHelper.dropShadow1()
    }
    
    override func updateConstraints() {
        if(shouldSetupConstraints) {
            
            //debugPrint("GG")
            //cellBackgroundView.autoCenterInSuperview()
            cellBackgroundView.autoAlignAxis(toSuperviewAxis: .vertical)
            cellBackgroundView.autoAlignAxis(toSuperviewAxis: .horizontal)
            
            //eventNameLabel.autoAlignAxis(toSuperviewAxis: .vertical)
            scheduleTimeLabel.autoPinEdge(toSuperviewEdge: .left, withInset: 10)
            scheduleTimeLabel.autoPinEdge(toSuperviewEdge: .top, withInset: 10)
            //eventNameLabel.autoSetDimensions(to: CGSize(width: screenSize.width - 60, height: 50))
            
            //eventNameLabel.autoAlignAxis(toSuperviewAxis: .horizontal)
            eventNameLabel.autoPinEdge(.top, to: .bottom, of: scheduleTimeLabel, withOffset: 0)
            eventNameLabel.autoPinEdge(toSuperviewEdge: .right, withInset: 10)
            eventNameLabel.autoPinEdge(toSuperviewEdge: .left, withInset: 10)
            

            selectedWorkshopLabel.autoPinEdge(toSuperviewEdge: .bottom, withInset: 10)
            selectedWorkshopLabel.autoPinEdge(toSuperviewEdge: .left, withInset: 10)
            
            if(selectedWorkshopLabel.isHidden){
                happeningNowWorkshopLabel.autoPinEdge(toSuperviewEdge: .bottom, withInset: 10)
                happeningNowWorkshopLabel.autoPinEdge(toSuperviewEdge: .left, withInset: 10)
            }else{
                happeningNowWorkshopLabel.autoPinEdge(toSuperviewEdge: .bottom, withInset: 10)
                happeningNowWorkshopLabel.autoPinEdge(.left, to: .right, of: selectedWorkshopLabel, withOffset: 10)
                //happeningNowWorkshopLabel.autoPinEdge(toSuperviewEdge: .right, withInset: 10)
            }
            
            //Set position if no workshop and happening label
            if (!selectedWorkshopLabel.isHidden){
                locationLabel.autoPinEdge(.top, to: .bottom, of: eventNameLabel, withOffset: 5)
                locationLabel.autoPinEdge(toSuperviewEdge: .left, withInset: 10)
            } else if (!happeningNowWorkshopLabel.isHidden){
                locationLabel.autoPinEdge(.top, to: .bottom, of: eventNameLabel, withOffset: 5)
                locationLabel.autoPinEdge(toSuperviewEdge: .left, withInset: 10)
            } else{
                locationLabel.autoPinEdge(toSuperviewEdge: .bottom, withInset: 20)
                locationLabel.autoPinEdge(toSuperviewEdge: .left, withInset: 10)
            }
            
            shouldSetupConstraints = false
        }
        super.updateConstraints()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }

}
